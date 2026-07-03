#+vet explicit-allocators
package shoot

import "base:intrinsics"
import "base:runtime"
import "core:log"
import "core:terminal"
import "core:terminal/ansi"
import "core:strings"
import "core:strconv"
import "core:os"
import "core:fmt"
import "core:sys/linux"
import "core:c/libc"

import "ga"
import "wayland"
import "wayland/wl"
import "wayland/ext"
import "wayland/wlr"
import "wayland/xdg"
import "png"

// IMPORTANT: this enum is very fragile and should not be changed,
// becuase a lot of checks rely on this specific set of values
Mode :: enum {
	Output,
	Toplevel,
	Selection
}

Output :: struct {
	wl:   wl.Output,
	xdg:  xdg.Output_V1,
	position: [2]i32,
	image:    Image
}

EXT_Toplevel :: struct {
	app_id, title: string
}

WLR_Toplevel :: struct {
	app_id, title: string,
	active:        bool,
	output:        wl.Output
}

Image :: struct {
	size:        [2]i32,
	stride:      i32,
	data:        uintptr,
	format:      wl.Shm_Format
}

Writer :: struct {
	arena:  ^ga.Arena,
	memory: []byte
}

main :: proc() {
	// NOTE: context setup
	permanent := ga.create()
	scratch   := ga.create()
	context.allocator      = ga.allocator(&permanent)
	context.temp_allocator = ga.allocator(&scratch)
	context.logger = {
		lowest_level = .Debug when ODIN_DEBUG else .Info,
		options      = terminal.color_enabled ? {.Terminal_Color} : {},
		procedure    = proc(data: rawptr, level: log.Level, text: string, options: log.Options, location := #caller_location) {
			builder := strings.builder_make(context.temp_allocator)

			color := .Terminal_Color in options
			if color {
				color: string = ---
				switch level {
				case .Debug:   color = ansi.FG_DEFAULT
				case .Info:    color = ansi.FAINT
				case .Warning: color = ansi.FG_YELLOW
				case .Error:   color = ansi.FG_RED
				case .Fatal:   color = ansi.FG_RED + ";" + ansi.BOLD
				}

				strings.write_string(&builder, ansi.CSI)
				strings.write_string(&builder, color)
				strings.write_string(&builder, ansi.SGR)
			}

			strings.write_string(&builder, text)
			if color {
				strings.write_string(&builder, ansi.CSI + ansi.RESET + ansi.SGR)
			}
			strings.write_byte(&builder, '\n')

			os.write(os.stderr, builder.buf[:])

			if level == .Fatal {
				os.exit(1)
			}
		}
	}

	// NOTE: arguments
	if len(os.args) < 2 {
		usage()
	}

	mode:                               Mode   = ---
	selection_position, selection_size: [2]i32 = ---, ---

	switch os.args[1] {
	case "output", "display", "monitor":
		mode = .Output
	case "toplevel", "window":
		mode = .Toplevel
	case "selection":
		if len(os.args) < 3 {
			usage()
		}

		selection := os.args[2]
		split     := strings.split(selection, " ", context.temp_allocator)
		position  := strings.split(split[0],  ",", context.temp_allocator)
		size      := strings.split(split[1],  "x", context.temp_allocator)

		x, ok_x := strconv.parse_i64(position[0], 10)
		y, ok_y := strconv.parse_i64(position[1], 10)
		w, ok_w := strconv.parse_i64(size[0],     10)
		h, ok_h := strconv.parse_i64(size[1],     10)
		if !ok_x || !ok_y || !ok_w || !ok_h { log.fatal("Invalid selection:", selection) }

		mode               = .Selection
		selection_position = {i32(x), i32(y)}
		selection_size     = {i32(w), i32(h)}
	case:
		usage()
	}

	// NOTE: connection, globals
	display           := wayland.display_connect()
	registry          := wl.display_get_registry(display)
	registry_callback := wl.display_sync(display)

	outputs := make([dynamic]Output, context.allocator)
	output_manager:   xdg.Output_Manager_V1
	toplevel_list:    ext.Foreign_Toplevel_List_V1
	toplevel_manager: wlr.Foreign_Toplevel_Manager_V1
	output_source:    ext.Output_Image_Capture_Source_Manager_V1
	toplevel_source:  ext.Foreign_Toplevel_Image_Capture_Source_Manager_V1
	capture_manager:  ext.Image_Copy_Capture_Manager_V1
	shm:              wl.Shm

	registry_loop: for {
		wayland.connection_flush()
		wayland.connection_poll()

		for event in wayland.connection_peek() {
			#partial switch event in event {
			case wl.Registry_Global_Event:
				switch event.interface {
				case wl.OUTPUT_INTERFACE:
					if mode != .Toplevel {
						output := wl.registry_bind(registry, event.name, event.interface, 1, wl.Output)
						if mode == .Selection {
							append(&outputs, Output{wl = output})
						}
					}
				case xdg.OUTPUT_MANAGER_V1_INTERFACE:
					if mode == .Selection {
						output_manager = wl.registry_bind(registry, event.name, event.interface, 1, xdg.Output_Manager_V1)
					}
				case ext.FOREIGN_TOPLEVEL_LIST_V1_INTERFACE:
					if mode != .Selection {
						toplevel_list = wl.registry_bind(registry, event.name, event.interface, 1, ext.Foreign_Toplevel_List_V1)
					}
				case wlr.FOREIGN_TOPLEVEL_MANAGER_V1_INTERFACE:
					if mode != .Selection {
						toplevel_manager = wl.registry_bind(registry, event.name, event.interface, 1, wlr.Foreign_Toplevel_Manager_V1)
					}
				case ext.OUTPUT_IMAGE_CAPTURE_SOURCE_MANAGER_V1_INTERFACE:
					if mode != .Toplevel {
						output_source = wl.registry_bind(registry, event.name, event.interface, 1, ext.Output_Image_Capture_Source_Manager_V1)
					}
				case ext.FOREIGN_TOPLEVEL_IMAGE_CAPTURE_SOURCE_MANAGER_V1_INTERFACE:
					if mode == .Toplevel {
						toplevel_source = wl.registry_bind(registry, event.name, event.interface, 1, ext.Foreign_Toplevel_Image_Capture_Source_Manager_V1)
					}
				case ext.IMAGE_COPY_CAPTURE_MANAGER_V1_INTERFACE:
					capture_manager = wl.registry_bind(registry, event.name, event.interface, 1, ext.Image_Copy_Capture_Manager_V1)
				case wl.SHM_INTERFACE:
					shm = wl.registry_bind(registry, event.name, event.interface, 1, wl.Shm)
				}

			case wl.Callback_Done_Event:
				assert(event.object == registry_callback)
				break registry_loop

			case wl.Display_Error_Event:
				display_error(event)
			}
		}

		free_all(context.temp_allocator)
	}

	missing: [dynamic; 5]string
	if mode == .Selection && output_manager   == 0 { append(&missing, xdg.OUTPUT_MANAGER_V1_INTERFACE)                                }
	if mode != .Selection && toplevel_list    == 0 { append(&missing, ext.FOREIGN_TOPLEVEL_LIST_V1_INTERFACE)                         }
	if mode != .Selection && toplevel_manager == 0 { append(&missing, wlr.FOREIGN_TOPLEVEL_MANAGER_V1_INTERFACE)                      }
	if mode != .Toplevel  && output_source    == 0 { append(&missing, ext.OUTPUT_IMAGE_CAPTURE_SOURCE_MANAGER_V1_INTERFACE)           }
	if mode == .Toplevel  && toplevel_source  == 0 { append(&missing, ext.FOREIGN_TOPLEVEL_IMAGE_CAPTURE_SOURCE_MANAGER_V1_INTERFACE) }
	if                       capture_manager  == 0 { append(&missing, ext.IMAGE_COPY_CAPTURE_MANAGER_V1_INTERFACE)                    }
	if                       shm              == 0 { append(&missing, wl.SHM_INTERFACE)                                               }

	if len(missing) > 0 {
		joined := strings.join(missing[:], ", ", context.temp_allocator)
		log.fatal("Missing global(s):", joined)
	}

	image: Image = ---
	if mode == .Selection {
		// NOTE: gather outputs
		for &output in outputs {
			output.xdg = xdg.output_manager_v1_get_xdg_output(output_manager, output.wl)
		}
		output_callback := wl.display_sync(display)
		output_loop: for {
			wayland.connection_flush()
			wayland.connection_poll()

			for event in wayland.connection_peek() {
				#partial switch event in event {
				case xdg.Output_V1_Logical_Position_Event:
					for &output in outputs {
						if output.xdg == event.object {
							output.position = {event.x, event.y}
							break
						}
					}

				case wl.Callback_Done_Event:
					assert(event.object == output_callback)
					break output_loop

				case wl.Display_Error_Event:
					display_error(event)
				}
			}
		}

		if len(outputs) > 1 {
			// NOTE: capture outputs
			for &output in outputs {
				output.image = queue_output_capture(capture_manager, shm, output_source, output.wl)
			}
			wait_captures(len(outputs))

			// NOTE: compose images
			bound_min := [2]i32{max(i32), max(i32)}
			bound_max := [2]i32{min(i32), min(i32)}
			for output in outputs {
				bound_min.x = min(output.position.x, bound_min.x)
				bound_min.y = min(output.position.y, bound_min.y)
				bound_max.x = max(output.position.x + output.image.size.x, bound_max.x)
				bound_max.y = max(output.position.y + output.image.size.y, bound_max.y)
			}

			// NOTE: the composite image is always RGB
			size        := bound_max - bound_min
			format      := outputs[0].image.format
			stride      := 4 * size.x
			composition := make([]byte, stride * size.y, context.allocator)

			// HACK: they can technically differ, but assuming they don't saves a bit of work
			when ODIN_DEBUG {
				for output in outputs[1:] {
					assert(output.image.format == format)
				}
			}

			for output in outputs {
				effective  := output.position - bound_min

				src_start  := output.image.data
				src_stride := uintptr(output.image.stride)
				dst_start  := uintptr(raw_data(composition)) + uintptr(effective.y * stride + effective.x * 4)
				dst_stride := uintptr(stride)

				for _ in 0..<output.image.size.y {
					intrinsics.mem_copy(rawptr(dst_start), rawptr(src_start), 4 * output.image.size.x)

					src_start += src_stride
					dst_start += dst_stride
				}
			}

			selection_position -= bound_min
			image = {
				size   = size,
				stride = stride,
				data   = uintptr(raw_data(composition)),
				format = format
			}
		} else {
			image = queue_output_capture(capture_manager, shm, output_source, outputs[0].wl)
			wait_captures(1)
		}

		// NOTE: crop to selection
		image.size  = selection_size
		image.data += uintptr(selection_position.y * image.stride + selection_position.x * 4)
	} else {
		// NOTE: collect toplevels
		toplevel_callback := wl.display_sync(display)

		ext_toplevels := make(map[ext.Foreign_Toplevel_Handle_V1]EXT_Toplevel, context.allocator)
		wlr_toplevels := make(map[wlr.Foreign_Toplevel_Handle_V1]WLR_Toplevel, context.allocator)

		// TODO: use the toplevel state protocol from ext instead of wlr
		// https://gitlab.freedesktop.org/wayland/wayland-protocols/-/merge_requests/196
		toplevel_loop: for {
			wayland.connection_flush()
			wayland.connection_poll()

			for event in wayland.connection_peek() {
				#partial switch event in event {
				case ext.Foreign_Toplevel_List_V1_Toplevel_Event:
					ext_toplevels[event.toplevel] = {}
				case ext.Foreign_Toplevel_Handle_V1_App_Id_Event:
					toplevel := &ext_toplevels[event.object]
					toplevel.app_id = strings.clone(event.app_id, context.allocator)
				case ext.Foreign_Toplevel_Handle_V1_Title_Event:
					toplevel := &ext_toplevels[event.object]
					toplevel.title = strings.clone(event.title, context.allocator)

				case wlr.Foreign_Toplevel_Manager_V1_Toplevel_Event:
					wlr_toplevels[event.toplevel] = {}
				case wlr.Foreign_Toplevel_Handle_V1_App_Id_Event:
					toplevel := &wlr_toplevels[event.object]
					toplevel.app_id = strings.clone(event.app_id, context.allocator)
				case wlr.Foreign_Toplevel_Handle_V1_Title_Event:
					toplevel := &wlr_toplevels[event.object]
					toplevel.title = strings.clone(event.title, context.allocator)
				case wlr.Foreign_Toplevel_Handle_V1_State_Event:
					active := false
					for i := 0; i < len(event.state); i += size_of(wlr.Foreign_Toplevel_Handle_V1_State) {
						state: wlr.Foreign_Toplevel_Handle_V1_State = ---
						intrinsics.mem_copy(&state, &event.state[i], size_of(state))

						if state == .Activated {
							active = true
							break
						}
					}

					toplevel := &wlr_toplevels[event.object]
					toplevel.active = active
				case wlr.Foreign_Toplevel_Handle_V1_Output_Enter_Event:
					toplevel := &wlr_toplevels[event.object]
					toplevel.output = event.output

				case wl.Callback_Done_Event:
					assert(event.object == toplevel_callback)
					break toplevel_loop

				case wl.Display_Error_Event:
					display_error(event)
				}
			}

			free_all(context.temp_allocator)
		}

		// NOTE: find active toplevel
		toplevel: ext.Foreign_Toplevel_Handle_V1
		output:   wl.Output

		outer: for wlr_id, wlr_toplevel in wlr_toplevels {
			if wlr_toplevel.active {
				for ext_id, ext_toplevel in ext_toplevels {
					if ext_toplevel.app_id == wlr_toplevel.app_id && ext_toplevel.title == wlr_toplevel.title {
						toplevel = ext_id
						output   = wlr_toplevel.output

						break outer
					}
				}
			}
		}

		// NOTE: capture
		#partial switch mode {
		case .Output:
			if output == 0 { log.fatal("Something went wrong") }
			image = queue_output_capture(capture_manager, shm, output_source, output)
		case .Toplevel:
			if toplevel == 0 { log.fatal("Something went wrong") }
			image = queue_toplevel_capture(capture_manager, shm, toplevel_source, toplevel)
		}
		wait_captures(1)
	}

	// NOTE: encode, output
	writer := png.create_write_struct(png.LIBPNG_VER_STRING, nil, nil, nil)
	png.init_io(writer, libc.stdout)

	info := png.create_info_struct(writer)
	png.set_IHDR(writer, info, u32(image.size.x), u32(image.size.y), 8, png.COLOR_TYPE_RGB, png.INTERLACE_NONE, png.COMPRESSION_TYPE_DEFAULT, png.FILTER_TYPE_DEFAULT)
	png.write_info(writer, info)

	#partial switch image.format {
	case .Xbgr8888, .Abgr8888:
		when ODIN_ENDIAN == .Big {
			png.set_bgr(writer)
		}
	case .Xrgb8888, .Argb8888:
		when ODIN_ENDIAN == .Little {
			png.set_bgr(writer)
		}
	case:
		log.fatal("Unsupported format:", image.format)
	}
	png.set_filler(writer, 0xff, png.FILLER_AFTER when ODIN_ENDIAN == .Little else png.FILLER_BEFORE)

	rows   := make([]^byte, image.size.y, context.temp_allocator)
	start  := uintptr(image.data)
	stride := uintptr(image.stride)
	for &row in rows {
		row = cast([^]byte)start
		start += stride
	}
	png.write_image(writer, raw_data(rows))

	png.write_end(writer, nil)
}

usage :: proc() {
	fmt.eprint(`Usage:
	shoot output/display/monitor
	shoot toplevel/window
	shoot selection "$(slurp)"

The image is always written to stdout as a PNG.
`)

	os.exit(1)
}

display_error :: proc(event: wl.Display_Error_Event) {
	type := wayland.get_object_type(u32(event.object_id))
	log.fatalf("%s error: %s", type, event.message)
}

capture_source :: proc(manager: ext.Image_Copy_Capture_Manager_V1, shm: wl.Shm, source: ext.Image_Capture_Source_V1) -> Image {
	// NOTE: create session
	session := ext.image_copy_capture_manager_v1_create_session(manager, source, nil)

	format: wl.Shm_Format = ---
	width, height: i32 = ---, ---
	session_loop: for {
		wayland.connection_flush()
		wayland.connection_poll()

		for event in wayland.connection_peek() {
			#partial switch event in event {
			case ext.Image_Copy_Capture_Session_V1_Buffer_Size_Event:
				width  = i32(event.width)
				height = i32(event.height)
			case ext.Image_Copy_Capture_Session_V1_Shm_Format_Event:
				format = event.format
			case ext.Image_Copy_Capture_Session_V1_Done_Event:
				break session_loop

			case wl.Display_Error_Event:
				display_error(event)
			}
		}
	}

	// NOTE: create buffer
	fd, fd_error := linux.memfd_create("image", {.CLOEXEC})
	if fd_error != nil { log.fatal("Failed to create memfd:", fd_error) }

	pixel_width := i32(4)
	stride      := pixel_width * width
	size        := height * stride
	linux.ftruncate(fd, i64(size))

	data, data_error := linux.mmap(0, uint(size), {.READ}, {.SHARED}, fd)
	if data_error != nil { log.fatal("Failed to map buffer data:", data_error) }

	pool   := wl.shm_create_pool(shm, fd, size)
	buffer := wl.shm_pool_create_buffer(pool, 0, width, height, stride, format)

	// NOTE: capture
	frame := ext.image_copy_capture_session_v1_create_frame(session)
	ext.image_copy_capture_frame_v1_attach_buffer(frame, buffer)
	ext.image_copy_capture_frame_v1_damage_buffer(frame, 0, 0, width, height)
	ext.image_copy_capture_frame_v1_capture(frame)

	return {
		size   = {width, height},
		stride = pixel_width * width,
		data   = uintptr(data),
		format = format
	}
}

queue_output_capture :: proc(capture_manager: ext.Image_Copy_Capture_Manager_V1, shm: wl.Shm, source_manager: ext.Output_Image_Capture_Source_Manager_V1, output: wl.Output) -> Image {
	source := ext.output_image_capture_source_manager_v1_create_source(source_manager, output)
	return capture_source(capture_manager, shm, source)
}

queue_toplevel_capture :: proc(capture_manager: ext.Image_Copy_Capture_Manager_V1, shm: wl.Shm, source_manager: ext.Foreign_Toplevel_Image_Capture_Source_Manager_V1, toplevel: ext.Foreign_Toplevel_Handle_V1) -> Image {
	source := ext.foreign_toplevel_image_capture_source_manager_v1_create_source(source_manager, toplevel)
	return capture_source(capture_manager, shm, source)
}

wait_captures :: proc(count: int) {
	remaining := count

	capture_loop: for {
		wayland.connection_flush()
		wayland.connection_poll()

		for event in wayland.connection_peek() {
			#partial switch event in event {
			case ext.Image_Copy_Capture_Frame_V1_Ready_Event:
				remaining -= 1
				if remaining <= 0 {
					break capture_loop
				}

			case wl.Display_Error_Event:
				display_error(event)
			}
		}
	}
}

package wayland_generator

import "base:runtime"
import "core:strings"
import "core:os"
import "core:fmt"

import "xml"

Context :: struct {
	imports:         map[string]struct{},
	interface_names: strings.Builder,
	enums:           strings.Builder,
	interfaces:      strings.Builder,
	events:          strings.Builder,
	readers:         strings.Builder,
	requests:        strings.Builder
}

main :: proc() {
	contexts     := make(map[string]Context, context.allocator)
	object_types := 0
	event_union  := strings.builder_make(context.allocator)
	read_event   := strings.builder_make(context.allocator)

	strings.write_string(&event_union, "Event :: union {\n")
	strings.write_string(&read_event, `read_event :: proc(object: u32, opcode: u16) -> Event {
	object_type := get_object_type(object)
	switch object_type {
`)

	for i := 1; i < len(runtime.args__); i += 1 {
		path := string(runtime.args__[i])
		data, error := os.read_entire_file(path, context.temp_allocator)
		if error != nil { fail("Failed to read %s: %s\n", path, error) }

		document := xml.parse(string(data), context.temp_allocator)
		protocol := document.children[0]
		if protocol.name != "protocol" { fail("Root element is not protocol\n") }

		for interface in protocol.children {
			if interface.name != "interface" { continue }

			interface_name_full       := strings.clone(interface.attributes["name"], context.allocator)
			namespace, interface_name := parse_interface_name(interface_name_full)
			interface_type            := to_ada_case(interface_name, context.temp_allocator)

			if namespace not_in contexts {
				contexts[namespace] = {}
			}
			ctx := &contexts[namespace]


			fmt.sbprintf(&ctx.interface_names, "%s_INTERFACE :: \"%s\"\n", strings.to_upper(interface_name, context.temp_allocator), interface_name_full)
			fmt.sbprintf(&ctx.interfaces, "%s :: distinct u32\n", interface_type)
			object_types += 1

			read_event_header := false
			request_opcode    := 0
			event_opcode      := 0
			sizes             := strings.builder_make(context.temp_allocator)
			variables         := strings.builder_make(context.temp_allocator)
			writes            := strings.builder_make(context.temp_allocator)
			for property in interface.children {
				property_name := fmt.tprintf("%s_%s", interface_name, property.attributes["name"])
				property_type := to_ada_case(property_name, context.temp_allocator)

				switch property.name {
				case "enum":
					fmt.sbprintf(&ctx.enums, "%s :: enum u32 {{\n", property_type)
					for entry in property.children {
						if entry.name != "entry" { continue }

						entry_name  := entry.attributes["name"]
						entry_field := to_ada_case(entry_name, context.temp_allocator)
						entry_value := entry.attributes["value"]

						start    := entry_field[0]
						is_digit := '0' <= start && start <= '9'
						format   := is_digit ? "\t_%s = %s,\n" : "\t%s = %s,\n"
						fmt.sbprintf(&ctx.enums, format, entry_field, entry_value)
					}
					strings.write_string(&ctx.enums, "}\n")
				case "request":
					strings.builder_reset(&variables)
					strings.builder_reset(&sizes)
					strings.builder_reset(&writes)

					fmt.sbprintf(&ctx.requests, "%s :: proc(_object: %s", property_name, interface_type)
					strings.write_byte(&sizes, '8')

					new_id_interface_type := ""
					request_loop: for arg in property.children {
						if arg.name != "arg" { continue }

						arg_name := arg.attributes["name"]
						arg_type := arg.attributes["type"]
						arg_cast := ""
						arg_size := " + size_of(%s)"
						switch arg_type {
						case "new_id":
							new_id_interface, ok := arg.attributes["interface"]
							if ok {
								new_id_interface_type = resolve_external_interface_type(ctx, namespace, new_id_interface, context.temp_allocator)
							} else {
								strings.write_string(&ctx.requests, ", _name: string, _version: u32, $T: typeid")
								strings.write_string(&variables, "\t_name := _name\n\t_version := _version\n")
								strings.write_string(&sizes, " + u16(runtime.align_forward(size_of(u32) + len(_name) + 1, 4)) + size_of(_version)")
								strings.write_string(&writes, "\twrite(&_name)\n\twrite(&_version)\n")
								new_id_interface_type = "T"
							}

							fmt.sbprintf(&variables, "\t_id := generate_id(%s)\n", new_id_interface_type)
							strings.write_string(&sizes, " + size_of(_id)")
							strings.write_string(&writes, "\twrite(&_id)\n")

							continue request_loop
						case "object":
							object_interface, ok := arg.attributes["interface"]
							if !ok {
								arg_type = "Object"
								break
							}

							arg_type = resolve_external_interface_type(ctx, namespace, object_interface, context.temp_allocator)
							arg_cast = "cast(u32)"
						case "uint":
							arg_enum, ok := arg.attributes["enum"]
							if ok {
								i := strings.index_byte(arg_enum, '.')

								enum_interface_type, enum_name: string = ---, ---
								if i >= 0 {
									enum_interface_type = resolve_external_interface_type(ctx, namespace, arg_enum[:i], context.temp_allocator)
									enum_name = arg_enum[i+1:]
								} else {
									enum_interface_type = interface_type
									enum_name = arg_enum
								}

								enum_name_ada := to_ada_case(enum_name, context.temp_allocator)
								arg_type = fmt.tprintf("%s_%s", enum_interface_type, enum_name_ada)
								arg_cast = "cast(u32)"
							} else {
								arg_type = "u32"
							}
						case "array":
							arg_type = "[]byte"
							arg_size = " + u16(runtime.align_forward(size_of(u32) + len(%s), 4))"
						case "fd":
							arg_type = "Fd"
							arg_size = ""
						case "fixed":
							arg_type = "f64"
							arg_size = "size_of(Fixed)"
						case "string":
							// arg_type = "string"
							arg_size = " + u16(runtime.align_forward(size_of(u32) + len(%s) + 1, 4))"
						case "int":
							arg_type = "i32"
						}

						fmt.sbprintf(&ctx.requests, ", %s: %s", arg_name, arg_type)
						fmt.sbprintf(&variables, "\t%s := %s%s\n", arg_name, arg_cast, arg_name)
						fmt.sbprintf(&sizes, arg_size, arg_name)
						fmt.sbprintf(&writes, "\twrite(&%s)\n", arg_name)
					}
					strings.write_string(&ctx.requests, ") ")

					if new_id_interface_type != "" {
						fmt.sbprintf(&ctx.requests, "-> %s ", new_id_interface_type)
					}

					strings.write_string(&ctx.requests, "{\n")
					strings.write_bytes(&ctx.requests, variables.buf[:])
					fmt.sbprintf(&ctx.requests, `	_object := cast(u32)_object
	_opcode: u16 = %i
	_size: u16 = `, request_opcode)
					strings.write_bytes(&ctx.requests, sizes.buf[:])
					strings.write_byte(&ctx.requests, '\n')
					strings.write_string(&ctx.requests, `	write(&_object)
	write(&_opcode)
	write(&_size)
`)
					strings.write_bytes(&ctx.requests, writes.buf[:])
					if new_id_interface_type != "" {
						fmt.sbprintf(&ctx.requests, "\treturn %s(_id)\n", new_id_interface_type)
					}
					strings.write_string(&ctx.requests, "}\n")

					request_opcode += 1
				case "event":
					fmt.sbprintf(&ctx.events, "%s_Event :: struct {{\n\tobject: %s,\n", property_type, interface_type)
					fmt.sbprintf(&ctx.readers, `read_%s :: proc(object: u32) -> %s_Event {{
	event: %s_Event = ---
	event.object = %s(object)
`, property_name, property_type, property_type, interface_type)

					event_loop: for arg in property.children {
						if arg.name != "arg" { continue }

						arg_name := arg.attributes["name"]
						arg_type := arg.attributes["type"]
						arg_cast := ""
						arg_post := ""
						switch arg_type {
						case "new_id":
							interface_name_full, ok := arg.attributes["interface"]
							arg_type = ok ? resolve_external_interface_type(ctx, namespace, interface_name_full, context.temp_allocator) : "Object"

							arg_cast = "cast(^u32)"
							arg_post = fmt.tprintf("\tconnection.server_object_types[u32(event.%s) - SERVER_ID_START] = %s\n", arg_name, arg_type)
						case "object":
							interface_name_full, ok := arg.attributes["interface"]
							arg_type = ok ? resolve_external_interface_type(ctx, namespace, interface_name_full, context.temp_allocator) : "Object"
							arg_cast = "cast(^u32)"
						case "uint":
							arg_enum, ok := arg.attributes["enum"]
							if ok {
								i := strings.index_byte(arg_enum, '.')

								enum_interface_type, enum_name: string = ---, ---
								if i >= 0 {
									enum_interface_type = resolve_external_interface_type(ctx, namespace, arg_enum[:i], context.temp_allocator)
									enum_name = arg_enum[i+1:]
								} else {
									enum_interface_type = interface_type
									enum_name = arg_enum
								}

								enum_name_ada := to_ada_case(enum_name, context.temp_allocator)
								arg_type = fmt.tprintf("%s_%s", enum_interface_type, enum_name_ada)
								arg_cast = "cast(^u32)"
							} else {
								arg_type = "u32"
							}
						case "int":   arg_type = "i32"
						case "fixed": arg_type = "f64"
						case "array": arg_type = "[]byte"
						case "fd":    arg_type = "Fd"
						// case "string": arg_type = "string"
						}

						fmt.sbprintf(&ctx.events, "\t%s: %s,\n", arg_name, arg_type)
						fmt.sbprintf(&ctx.readers, "\tread(%s&event.%s)\n%s", arg_cast, arg_name, arg_post)
					}

					strings.write_string(&ctx.events, "}\n")
					strings.write_string(&ctx.readers, "\treturn event\n}\n")


					fmt.sbprintf(&event_union, "\t%s.%s_Event,\n", namespace, property_type)

					if !read_event_header {
						fmt.sbprintf(&read_event, "\tcase %s.%s:\n\t\tswitch opcode {{\n", namespace, interface_type)
						read_event_header = true
					}
					fmt.sbprintf(&read_event, "\t\tcase %i: return %s.read_%s(object)\n", event_opcode, namespace, property_name)
					event_opcode += 1
				}
			}
			if read_event_header {
				strings.write_string(&read_event, "\t\t}\n")
			}
		}

		free_all(context.temp_allocator)
	}

	strings.write_string(&event_union, "}\n")
	strings.write_string(&read_event, "\t}\n\treturn nil\n}\n")

	namespace_builder := strings.builder_make(context.temp_allocator)
	global_builder    := strings.builder_make(context.temp_allocator)

	strings.write_string(&global_builder, "package wayland\n\n")

	for namespace, ctx in contexts {
		error := os.mkdir(namespace)
		if error != nil && error != .Exist { fail("Failed to create directory %s: %s\n", namespace, error) }

		generated_path := fmt.tprintf("%s/generated.odin", namespace)


		strings.builder_reset(&namespace_builder)
		fmt.sbprintf(&namespace_builder, "package wayland_%s\n\n", namespace)
		strings.write_string(&namespace_builder, "import \"base:runtime\"\nimport common \"../common\"\n\n")
		for other in ctx.imports {
			fmt.sbprintf(&namespace_builder, "import \"../%s\"\n", other)
		}
		strings.write_string(&namespace_builder, `
Object     :: common.Object
Fd         :: common.Fd
Fixed      :: i32

SERVER_ID_START :: common.SERVER_ID_START

connection := &common.connection

generate_id :: common.generate_id
read        :: common.read
write       :: common.write

`)
		strings.write_bytes(&namespace_builder, ctx.interface_names.buf[:]); strings.write_byte(&namespace_builder, '\n')
		strings.write_bytes(&namespace_builder, ctx.interfaces.buf[:]);      strings.write_byte(&namespace_builder, '\n')
		strings.write_bytes(&namespace_builder, ctx.enums.buf[:]);           strings.write_byte(&namespace_builder, '\n')
		strings.write_bytes(&namespace_builder, ctx.events.buf[:]);          strings.write_byte(&namespace_builder, '\n')
		strings.write_bytes(&namespace_builder, ctx.readers.buf[:]);         strings.write_byte(&namespace_builder, '\n')
		strings.write_bytes(&namespace_builder, ctx.requests.buf[:])

		write(generated_path, namespace_builder.buf[:])


		fmt.sbprintf(&global_builder, "import \"%s\"\n", namespace)
	}

	strings.write_bytes(&global_builder, event_union.buf[:])
	strings.write_byte(&global_builder, '\n')
	strings.write_bytes(&global_builder, read_event.buf[:])

	write("generated.odin", global_builder.buf[:])


	strings.builder_reset(&global_builder)
	fmt.sbprintf(&global_builder, "package wayland_common\n\nOBJECT_TYPE_COUNT :: %i\n", object_types)

	write("common/generated.odin", global_builder.buf[:])
}

parse_interface_name :: proc(interface: string) -> (string, string) {
	index := strings.index_byte(interface, '_')
	if index < 0 { fail("%s does not have a namespace\n", interface) }

	namespace := interface[(interface[0] == 'z' ? 1 : 0):index]
	name      := interface[index+1:]

	return namespace, name
}

resolve_external_interface_type :: proc(ctx: ^Context, current_namespace, interface_name_full: string, allocator: runtime.Allocator) -> string {
	interface_namespace, interface_name := parse_interface_name(interface_name_full)
	interface_type := to_ada_case(interface_name, context.temp_allocator)

	if interface_namespace != current_namespace {
		if interface_namespace not_in ctx.imports {
			cloned := strings.clone(interface_namespace, context.allocator)
			ctx.imports[cloned] = {}
		}

		return fmt.aprintf("%s.%s", interface_namespace, interface_type, allocator = allocator)
	} else {
		return interface_type
	}
}

to_ada_case :: proc(s: string, allocator: runtime.Allocator) -> string {
	result := make([]u8, len(s), allocator)
	upper := true
	for i in 0..<len(s) {
		c := s[i]

		result[i] = upper && 'a' <= c && c <= 'z' ? c - 'a' + 'A' : c
		upper = c == '_'
	}
	return string(result)
}

write :: proc(path: string, data: []byte) {
	file, error := os.open(path, {.Create, .Trunc, .Write})
	if error != nil { fail("Failed to open %s: %s\n", path, error) }
	defer os.close(file)

	start := 0
	for start < len(data) {
		n, error := os.write(file, data[start:])
		if error != nil { fail("Failed to write to %s: %s\n", path, error) }

		start += n
	}
}

fail :: proc(format: string, args: ..any) {
	fmt.eprintf(format, ..args)
	os.exit(1)
}

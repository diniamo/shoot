package wayland

import "base:runtime"
import "base:intrinsics"
import "core:sys/linux"
import "core:os"
import "core:log"
import "core:strings"
import "core:strconv"
import "core:slice"

import "common"
import "wl"

Connection :: common.Connection

@(private="file")
Control_Header :: struct {
	len: u64,
	level, type: i32,
	data: struct{}
}

connection := &common.connection

display_connect :: proc() -> wl.Display {
	path := os.lookup_env("WAYLAND_DISPLAY", context.temp_allocator) or_else "wayland-0"
	if path[0] != '/' {
		runtime_dir, have_runtime_dir := os.lookup_env("XDG_RUNTIME_DIR", context.temp_allocator)
		if !have_runtime_dir { log.fatal("XDG_RUNTIME_DIR environment variable is missing") }

		path = strings.concatenate({runtime_dir, "/", path}, context.temp_allocator)
	}

	socket: linux.Fd = ---
	socket_string, have_socket := os.lookup_env("WAYLAND_SOCKET", context.temp_allocator)
	if have_socket {
		socket_number, socket_valid := strconv.parse_u64(socket_string, 10)
		if !socket_valid { log.fatal("Failed to parse FD number (from WAYLAND_SOCKET): %s", socket_string) }

		socket = cast(linux.Fd)socket_number
	} else {
		errno: linux.Errno = ---
		socket, errno = linux.socket(.UNIX, .STREAM, {.CLOEXEC}, {})
		if errno != nil { log.fatal("Failed to create socket: %s", errno) }
	}

	address := linux.Sock_Addr_Un{sun_family = .UNIX}
	copy(address.sun_path[:], path)

	errno := linux.connect(socket, &address)
	if errno != nil { log.fatal("Failed to connect to %s: %s", path, errno) }

	connection.socket                 = socket
	connection.used_ids               = 2
	connection.client_object_types[1] = wl.Display

	return wl.Display(1)
}

connection_poll :: proc() {
	if connection.start_in > 0 {
		copy(connection.buffer_in[:], connection.buffer_in[connection.start_in:connection.end_in])
		connection.end_in   -= connection.start_in
		connection.start_in  = 0
	}

	message_header := linux.Msg_Hdr{
		iov     = []linux.IO_Vec{{&connection.buffer_in[connection.end_in], uint(len(connection.buffer_in) - connection.end_in)}},
		control = make([]byte, size_of(Control_Header) + common.MAX_FDS*size_of(linux.Fd), context.temp_allocator)
	}

	received: int = ---
	errno: linux.Errno = ---
	for {
		received, errno = linux.recvmsg(connection.socket, &message_header, {.CMSG_CLOEXEC})
		if errno != .EINTR { break }
	}

	switch {
	case received == 0: log.fatal("Disconnected from Wayland server")
	case received <  0: log.fatal("Unexpected error while receiving Wayland message: %s", errno)
	}

	connection.end_in += received

	if len(message_header.control) > 0 {
		control_header := cast(^Control_Header)raw_data(message_header.control)
		fds := slice.reinterpret([]linux.Fd, message_header.control[size_of(Control_Header):control_header.len])
		append(&connection.fds_in, ..fds)
	}
}

connection_peek :: proc() -> (Event, bool) {
	header: bit_field [2]u32 {
		object: u32 | 32,
		opcode: u16 | 16,
		size:   u16 | 16
	}

	remaining := connection.end_in - connection.start_in
	if remaining < size_of(header) { return nil, false }

	intrinsics.mem_copy(&header, &connection.buffer_in[connection.start_in], size_of(header))
	if remaining < int(header.size) { return nil, false }

	connection.start_in += size_of(header)

	event := read_event(header.object, header.opcode)
	if deleted, ok := event.(wl.Display_Delete_Id_Event); ok {
		append(&connection.free_ids, deleted.id)
		return connection_peek()
	} else {
		return event, true
	}
}

connection_flush :: proc() {
	message_header: linux.Msg_Hdr

	message_header.iov        = []linux.IO_Vec{{&connection.buffer_out[0], uint(connection.end_out)}}
	message_header.control    = make([]byte, size_of(Control_Header) + len(connection.fds_out)*size_of(linux.Fd), context.temp_allocator)

	control_header := cast(^Control_Header)raw_data(message_header.control)
	control_header.len   = u64(len(message_header.control))
	control_header.level = i32(linux.SOL_SOCKET)
	control_header.type  = 1 // SCM_RIGHTS

	fds := slice.reinterpret([]linux.Fd, message_header.control[offset_of(Control_Header, data):])
	copy(fds, connection.fds_out[:])

	sent: int = ---
	errno: linux.Errno = ---
	for {
		sent, errno = linux.sendmsg(connection.socket, &message_header, {.NOSIGNAL, .DONTWAIT})
		if errno != .EINTR { break }
	}

	// NOTE: EAGAIN means we should keep running and retry, other errors are unexpected
	#partial switch errno {
	case nil:     break
	case .EAGAIN: return
	case:         log.fatal("Unexpected error while sending Wayland message: %s", errno)
	}

	if sent < connection.end_out {
		copy(connection.buffer_out[:], connection.buffer_out[sent:])
		connection.end_out -= sent
	} else {
		connection.end_out = 0
	}

	// NOTE: libwayland also closes file descriptors, so we do the same here
	for fd in connection.fds_out { linux.close(fd) }
	clear(&connection.fds_out)
}

get_object_type :: proc(object: u32) -> typeid {
	return object < common.SERVER_ID_START ? connection.client_object_types[object] :
	                                         connection.server_object_types[object - common.SERVER_ID_START]
}

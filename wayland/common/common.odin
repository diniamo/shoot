package wayland_common

import "base:runtime"
import "base:intrinsics"
import "core:sys/linux"
import "core:math"

// NOTE: from libwayland
MAX_MESSAGE_SIZE :: 4096
MAX_FDS          :: 28

SERVER_ID_START :: 0xff000000

Object :: distinct u32
Fd     :: linux.Fd

Connection :: struct {
	socket:              linux.Fd,

	buffer_in:           [MAX_MESSAGE_SIZE]byte,
	start_in, end_in:    int,
	fds_in:              [dynamic; MAX_FDS]linux.Fd,

	buffer_out:          [MAX_MESSAGE_SIZE]byte,
	end_out:             int,
	fds_out:             [dynamic; MAX_FDS]linux.Fd,

	free_ids:            [dynamic; OBJECT_TYPE_COUNT]u32,
	used_ids:            u32,
	// NOTE:
	//   - indexed directly with object IDs
	//   - client IDs start at 1
	client_object_types: [OBJECT_TYPE_COUNT + 1]typeid,
	server_object_types: [OBJECT_TYPE_COUNT]typeid
}

connection: Connection

generate_id :: proc(type: typeid) -> u32 {
	id: u32 = ---

	if len(connection.free_ids) > 0 {
		// NOTE: the Wayland protocol requires densely packed IDs
		index, value := 0, connection.free_ids[0]
		for i in 1..<len(connection.free_ids) {
			v := connection.free_ids[i]

			if v < value {
				index, value = i, v
			}
		}

		id = value
		unordered_remove(&connection.free_ids, index)
	} else {
		id = connection.used_ids
		connection.used_ids += 1
	}

	connection.client_object_types[id] = type
	return id
}

read_int :: proc(data: ^i32) {
	intrinsics.mem_copy(data, &connection.buffer_in[connection.start_in], size_of(i32))
	connection.start_in += size_of(i32)
}
read_uint :: proc(data: ^u32) {
	intrinsics.mem_copy(data, &connection.buffer_in[connection.start_in], size_of(u32))
	connection.start_in += size_of(u32)
}
read_fixed :: proc(data: ^f64) {
	fixed: i32 = ---
	intrinsics.mem_copy(&fixed, &connection.buffer_in[connection.start_in], size_of(fixed))
	connection.start_in += size_of(fixed)
	data^ = f64(fixed) / 256.0
}
read_string :: proc(data: ^string) {
	n: u32 = ---
	read_uint(&n)
	length := int(n)

	// NOTE: the length includes a null terminator, which we don't include, but still skip
	data^ = string(connection.buffer_in[connection.start_in:connection.start_in + length - 1])
	connection.start_in = runtime.align_forward(connection.start_in + length, 4)
}
read_array :: proc(data: ^[]byte) {
	n: u32 = ---
	read_uint(&n)
	length := int(n)

	data ^= connection.buffer_in[connection.start_in:connection.start_in + length]
	connection.start_in = runtime.align_forward(connection.start_in + length, 4)
}
read_fd :: proc(data: ^Fd) {
	data^ = pop_front(&connection.fds_in)
}
read :: proc {
	read_int,
	read_uint,
	read_fixed,
	read_string,
	read_array,
	read_fd
}

write_header_part :: proc(data: ^u16) {
	size := size_of(u16)
	intrinsics.mem_copy(&connection.buffer_out[connection.end_out], data, size)
	connection.end_out += size
}
write_int :: proc(data: ^i32) {
	size := size_of(i32)
	intrinsics.mem_copy(&connection.buffer_out[connection.end_out], data, size)
	connection.end_out += size
}
write_uint :: proc(data: ^u32) {
	size := size_of(u32)
	intrinsics.mem_copy(&connection.buffer_out[connection.end_out], data, size)
	connection.end_out += size
}
write_fixed :: proc(data: ^f64) {
	fixed := cast(i32)math.round(data^ * 256.0)
	intrinsics.mem_copy(&connection.buffer_out[connection.end_out], &fixed, size_of(fixed))
	connection.end_out += size_of(fixed)
}
write_string :: proc(data: ^string) {
	s := data^
	length := u32(len(s)) + 1

	intrinsics.mem_copy(&connection.buffer_out[connection.end_out], &length, size_of(length)); connection.end_out += size_of(length)
	intrinsics.mem_copy(&connection.buffer_out[connection.end_out], raw_data(s), len(s));      connection.end_out += len(s)
	connection.buffer_out[connection.end_out] = 0;                                  connection.end_out += 1
	connection.end_out = runtime.align_forward(connection.end_out, 4)
}
write_array :: proc(data: ^[]byte) {
	a := data^
	length := u32(len(a))

	intrinsics.mem_copy(&connection.buffer_out[connection.end_out], &length, size_of(length)); connection.end_out += size_of(length)
	intrinsics.mem_copy(&connection.buffer_out[connection.end_out], raw_data(a), len(a));      connection.end_out += len(a)
	connection.end_out = runtime.align_forward(connection.end_out, 4)
}
write_fd :: proc(data: ^Fd) {
	append(&connection.fds_out, data^)
}
write :: proc {
	write_header_part,
	write_int,
	write_uint,
	write_fixed,
	write_string,
	write_array,
	write_fd
}

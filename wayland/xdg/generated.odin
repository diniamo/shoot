package wayland_xdg

import "base:runtime"
import common "../common"

import "../wl"

Object     :: common.Object
Fd         :: common.Fd
Fixed      :: i32

SERVER_ID_START :: common.SERVER_ID_START

connection := &common.connection

generate_id :: common.generate_id
read        :: common.read
write       :: common.write

OUTPUT_MANAGER_V1_INTERFACE :: "zxdg_output_manager_v1"
OUTPUT_V1_INTERFACE :: "zxdg_output_v1"

Output_Manager_V1 :: distinct u32
Output_V1 :: distinct u32


Output_V1_Logical_Position_Event :: struct {
	object: Output_V1,
	x: i32,
	y: i32,
}
Output_V1_Logical_Size_Event :: struct {
	object: Output_V1,
	width: i32,
	height: i32,
}
Output_V1_Done_Event :: struct {
	object: Output_V1,
}
Output_V1_Name_Event :: struct {
	object: Output_V1,
	name: string,
}
Output_V1_Description_Event :: struct {
	object: Output_V1,
	description: string,
}

read_output_v1_logical_position :: proc(object: u32) -> Output_V1_Logical_Position_Event {
	event: Output_V1_Logical_Position_Event = ---
	event.object = Output_V1(object)
	read(&event.x)
	read(&event.y)
	return event
}
read_output_v1_logical_size :: proc(object: u32) -> Output_V1_Logical_Size_Event {
	event: Output_V1_Logical_Size_Event = ---
	event.object = Output_V1(object)
	read(&event.width)
	read(&event.height)
	return event
}
read_output_v1_done :: proc(object: u32) -> Output_V1_Done_Event {
	event: Output_V1_Done_Event = ---
	event.object = Output_V1(object)
	return event
}
read_output_v1_name :: proc(object: u32) -> Output_V1_Name_Event {
	event: Output_V1_Name_Event = ---
	event.object = Output_V1(object)
	read(&event.name)
	return event
}
read_output_v1_description :: proc(object: u32) -> Output_V1_Description_Event {
	event: Output_V1_Description_Event = ---
	event.object = Output_V1(object)
	read(&event.description)
	return event
}

output_manager_v1_destroy :: proc(_object: Output_Manager_V1) {
	_object := cast(u32)_object
	_opcode: u16 = 0
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
output_manager_v1_get_xdg_output :: proc(_object: Output_Manager_V1, output: wl.Output) -> Output_V1 {
	_id := generate_id(Output_V1)
	output := cast(u32)output
	_object := cast(u32)_object
	_opcode: u16 = 1
	_size: u16 = 8 + size_of(_id) + size_of(output)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&_id)
	write(&output)
	return Output_V1(_id)
}
output_v1_destroy :: proc(_object: Output_V1) {
	_object := cast(u32)_object
	_opcode: u16 = 0
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}

package wayland_wlr

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

FOREIGN_TOPLEVEL_MANAGER_V1_INTERFACE :: "zwlr_foreign_toplevel_manager_v1"
FOREIGN_TOPLEVEL_HANDLE_V1_INTERFACE :: "zwlr_foreign_toplevel_handle_v1"

Foreign_Toplevel_Manager_V1 :: distinct u32
Foreign_Toplevel_Handle_V1 :: distinct u32

Foreign_Toplevel_Handle_V1_State :: enum u32 {
	Maximized = 0,
	Minimized = 1,
	Activated = 2,
	Fullscreen = 3,
}
Foreign_Toplevel_Handle_V1_Error :: enum u32 {
	Invalid_Rectangle = 0,
}

Foreign_Toplevel_Manager_V1_Toplevel_Event :: struct {
	object: Foreign_Toplevel_Manager_V1,
	toplevel: Foreign_Toplevel_Handle_V1,
}
Foreign_Toplevel_Manager_V1_Finished_Event :: struct {
	object: Foreign_Toplevel_Manager_V1,
}
Foreign_Toplevel_Handle_V1_Title_Event :: struct {
	object: Foreign_Toplevel_Handle_V1,
	title: string,
}
Foreign_Toplevel_Handle_V1_App_Id_Event :: struct {
	object: Foreign_Toplevel_Handle_V1,
	app_id: string,
}
Foreign_Toplevel_Handle_V1_Output_Enter_Event :: struct {
	object: Foreign_Toplevel_Handle_V1,
	output: wl.Output,
}
Foreign_Toplevel_Handle_V1_Output_Leave_Event :: struct {
	object: Foreign_Toplevel_Handle_V1,
	output: wl.Output,
}
Foreign_Toplevel_Handle_V1_State_Event :: struct {
	object: Foreign_Toplevel_Handle_V1,
	state: []byte,
}
Foreign_Toplevel_Handle_V1_Done_Event :: struct {
	object: Foreign_Toplevel_Handle_V1,
}
Foreign_Toplevel_Handle_V1_Closed_Event :: struct {
	object: Foreign_Toplevel_Handle_V1,
}
Foreign_Toplevel_Handle_V1_Parent_Event :: struct {
	object: Foreign_Toplevel_Handle_V1,
	parent: Foreign_Toplevel_Handle_V1,
}

read_foreign_toplevel_manager_v1_toplevel :: proc(object: u32) -> Foreign_Toplevel_Manager_V1_Toplevel_Event {
	event: Foreign_Toplevel_Manager_V1_Toplevel_Event = ---
	event.object = Foreign_Toplevel_Manager_V1(object)
	read(cast(^u32)&event.toplevel)
	connection.server_object_types[u32(event.toplevel) - SERVER_ID_START] = Foreign_Toplevel_Handle_V1
	return event
}
read_foreign_toplevel_manager_v1_finished :: proc(object: u32) -> Foreign_Toplevel_Manager_V1_Finished_Event {
	event: Foreign_Toplevel_Manager_V1_Finished_Event = ---
	event.object = Foreign_Toplevel_Manager_V1(object)
	return event
}
read_foreign_toplevel_handle_v1_title :: proc(object: u32) -> Foreign_Toplevel_Handle_V1_Title_Event {
	event: Foreign_Toplevel_Handle_V1_Title_Event = ---
	event.object = Foreign_Toplevel_Handle_V1(object)
	read(&event.title)
	return event
}
read_foreign_toplevel_handle_v1_app_id :: proc(object: u32) -> Foreign_Toplevel_Handle_V1_App_Id_Event {
	event: Foreign_Toplevel_Handle_V1_App_Id_Event = ---
	event.object = Foreign_Toplevel_Handle_V1(object)
	read(&event.app_id)
	return event
}
read_foreign_toplevel_handle_v1_output_enter :: proc(object: u32) -> Foreign_Toplevel_Handle_V1_Output_Enter_Event {
	event: Foreign_Toplevel_Handle_V1_Output_Enter_Event = ---
	event.object = Foreign_Toplevel_Handle_V1(object)
	read(cast(^u32)&event.output)
	return event
}
read_foreign_toplevel_handle_v1_output_leave :: proc(object: u32) -> Foreign_Toplevel_Handle_V1_Output_Leave_Event {
	event: Foreign_Toplevel_Handle_V1_Output_Leave_Event = ---
	event.object = Foreign_Toplevel_Handle_V1(object)
	read(cast(^u32)&event.output)
	return event
}
read_foreign_toplevel_handle_v1_state :: proc(object: u32) -> Foreign_Toplevel_Handle_V1_State_Event {
	event: Foreign_Toplevel_Handle_V1_State_Event = ---
	event.object = Foreign_Toplevel_Handle_V1(object)
	read(&event.state)
	return event
}
read_foreign_toplevel_handle_v1_done :: proc(object: u32) -> Foreign_Toplevel_Handle_V1_Done_Event {
	event: Foreign_Toplevel_Handle_V1_Done_Event = ---
	event.object = Foreign_Toplevel_Handle_V1(object)
	return event
}
read_foreign_toplevel_handle_v1_closed :: proc(object: u32) -> Foreign_Toplevel_Handle_V1_Closed_Event {
	event: Foreign_Toplevel_Handle_V1_Closed_Event = ---
	event.object = Foreign_Toplevel_Handle_V1(object)
	return event
}
read_foreign_toplevel_handle_v1_parent :: proc(object: u32) -> Foreign_Toplevel_Handle_V1_Parent_Event {
	event: Foreign_Toplevel_Handle_V1_Parent_Event = ---
	event.object = Foreign_Toplevel_Handle_V1(object)
	read(cast(^u32)&event.parent)
	return event
}

foreign_toplevel_manager_v1_stop :: proc(_object: Foreign_Toplevel_Manager_V1) {
	_object := cast(u32)_object
	_opcode: u16 = 0
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
foreign_toplevel_handle_v1_set_maximized :: proc(_object: Foreign_Toplevel_Handle_V1) {
	_object := cast(u32)_object
	_opcode: u16 = 0
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
foreign_toplevel_handle_v1_unset_maximized :: proc(_object: Foreign_Toplevel_Handle_V1) {
	_object := cast(u32)_object
	_opcode: u16 = 1
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
foreign_toplevel_handle_v1_set_minimized :: proc(_object: Foreign_Toplevel_Handle_V1) {
	_object := cast(u32)_object
	_opcode: u16 = 2
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
foreign_toplevel_handle_v1_unset_minimized :: proc(_object: Foreign_Toplevel_Handle_V1) {
	_object := cast(u32)_object
	_opcode: u16 = 3
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
foreign_toplevel_handle_v1_activate :: proc(_object: Foreign_Toplevel_Handle_V1, seat: wl.Seat) {
	seat := cast(u32)seat
	_object := cast(u32)_object
	_opcode: u16 = 4
	_size: u16 = 8 + size_of(seat)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&seat)
}
foreign_toplevel_handle_v1_close :: proc(_object: Foreign_Toplevel_Handle_V1) {
	_object := cast(u32)_object
	_opcode: u16 = 5
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
foreign_toplevel_handle_v1_set_rectangle :: proc(_object: Foreign_Toplevel_Handle_V1, surface: wl.Surface, x: i32, y: i32, width: i32, height: i32) {
	surface := cast(u32)surface
	x := x
	y := y
	width := width
	height := height
	_object := cast(u32)_object
	_opcode: u16 = 6
	_size: u16 = 8 + size_of(surface) + size_of(x) + size_of(y) + size_of(width) + size_of(height)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&surface)
	write(&x)
	write(&y)
	write(&width)
	write(&height)
}
foreign_toplevel_handle_v1_destroy :: proc(_object: Foreign_Toplevel_Handle_V1) {
	_object := cast(u32)_object
	_opcode: u16 = 7
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
foreign_toplevel_handle_v1_set_fullscreen :: proc(_object: Foreign_Toplevel_Handle_V1, output: wl.Output) {
	output := cast(u32)output
	_object := cast(u32)_object
	_opcode: u16 = 8
	_size: u16 = 8 + size_of(output)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&output)
}
foreign_toplevel_handle_v1_unset_fullscreen :: proc(_object: Foreign_Toplevel_Handle_V1) {
	_object := cast(u32)_object
	_opcode: u16 = 9
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}

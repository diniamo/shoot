package wayland_ext

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

FOREIGN_TOPLEVEL_LIST_V1_INTERFACE :: "ext_foreign_toplevel_list_v1"
FOREIGN_TOPLEVEL_HANDLE_V1_INTERFACE :: "ext_foreign_toplevel_handle_v1"
IMAGE_CAPTURE_SOURCE_V1_INTERFACE :: "ext_image_capture_source_v1"
OUTPUT_IMAGE_CAPTURE_SOURCE_MANAGER_V1_INTERFACE :: "ext_output_image_capture_source_manager_v1"
FOREIGN_TOPLEVEL_IMAGE_CAPTURE_SOURCE_MANAGER_V1_INTERFACE :: "ext_foreign_toplevel_image_capture_source_manager_v1"
IMAGE_COPY_CAPTURE_MANAGER_V1_INTERFACE :: "ext_image_copy_capture_manager_v1"
IMAGE_COPY_CAPTURE_SESSION_V1_INTERFACE :: "ext_image_copy_capture_session_v1"
IMAGE_COPY_CAPTURE_FRAME_V1_INTERFACE :: "ext_image_copy_capture_frame_v1"
IMAGE_COPY_CAPTURE_CURSOR_SESSION_V1_INTERFACE :: "ext_image_copy_capture_cursor_session_v1"

Foreign_Toplevel_List_V1 :: distinct u32
Foreign_Toplevel_Handle_V1 :: distinct u32
Image_Capture_Source_V1 :: distinct u32
Output_Image_Capture_Source_Manager_V1 :: distinct u32
Foreign_Toplevel_Image_Capture_Source_Manager_V1 :: distinct u32
Image_Copy_Capture_Manager_V1 :: distinct u32
Image_Copy_Capture_Session_V1 :: distinct u32
Image_Copy_Capture_Frame_V1 :: distinct u32
Image_Copy_Capture_Cursor_Session_V1 :: distinct u32

Image_Copy_Capture_Manager_V1_Error :: enum u32 {
	Invalid_Option = 1,
}
Image_Copy_Capture_Manager_V1_Options :: enum u32 {
	Paint_Cursors = 1,
}
Image_Copy_Capture_Session_V1_Error :: enum u32 {
	Duplicate_Frame = 1,
}
Image_Copy_Capture_Frame_V1_Error :: enum u32 {
	No_Buffer = 1,
	Invalid_Buffer_Damage = 2,
	Already_Captured = 3,
}
Image_Copy_Capture_Frame_V1_Failure_Reason :: enum u32 {
	Unknown = 0,
	Buffer_Constraints = 1,
	Stopped = 2,
}
Image_Copy_Capture_Cursor_Session_V1_Error :: enum u32 {
	Duplicate_Session = 1,
}

Foreign_Toplevel_List_V1_Toplevel_Event :: struct {
	object: Foreign_Toplevel_List_V1,
	toplevel: Foreign_Toplevel_Handle_V1,
}
Foreign_Toplevel_List_V1_Finished_Event :: struct {
	object: Foreign_Toplevel_List_V1,
}
Foreign_Toplevel_Handle_V1_Closed_Event :: struct {
	object: Foreign_Toplevel_Handle_V1,
}
Foreign_Toplevel_Handle_V1_Done_Event :: struct {
	object: Foreign_Toplevel_Handle_V1,
}
Foreign_Toplevel_Handle_V1_Title_Event :: struct {
	object: Foreign_Toplevel_Handle_V1,
	title: string,
}
Foreign_Toplevel_Handle_V1_App_Id_Event :: struct {
	object: Foreign_Toplevel_Handle_V1,
	app_id: string,
}
Foreign_Toplevel_Handle_V1_Identifier_Event :: struct {
	object: Foreign_Toplevel_Handle_V1,
	identifier: string,
}
Image_Copy_Capture_Session_V1_Buffer_Size_Event :: struct {
	object: Image_Copy_Capture_Session_V1,
	width: u32,
	height: u32,
}
Image_Copy_Capture_Session_V1_Shm_Format_Event :: struct {
	object: Image_Copy_Capture_Session_V1,
	format: wl.Shm_Format,
}
Image_Copy_Capture_Session_V1_Dmabuf_Device_Event :: struct {
	object: Image_Copy_Capture_Session_V1,
	device: []byte,
}
Image_Copy_Capture_Session_V1_Dmabuf_Format_Event :: struct {
	object: Image_Copy_Capture_Session_V1,
	format: u32,
	modifiers: []byte,
}
Image_Copy_Capture_Session_V1_Done_Event :: struct {
	object: Image_Copy_Capture_Session_V1,
}
Image_Copy_Capture_Session_V1_Stopped_Event :: struct {
	object: Image_Copy_Capture_Session_V1,
}
Image_Copy_Capture_Frame_V1_Transform_Event :: struct {
	object: Image_Copy_Capture_Frame_V1,
	transform: wl.Output_Transform,
}
Image_Copy_Capture_Frame_V1_Damage_Event :: struct {
	object: Image_Copy_Capture_Frame_V1,
	x: i32,
	y: i32,
	width: i32,
	height: i32,
}
Image_Copy_Capture_Frame_V1_Presentation_Time_Event :: struct {
	object: Image_Copy_Capture_Frame_V1,
	tv_sec_hi: u32,
	tv_sec_lo: u32,
	tv_nsec: u32,
}
Image_Copy_Capture_Frame_V1_Ready_Event :: struct {
	object: Image_Copy_Capture_Frame_V1,
}
Image_Copy_Capture_Frame_V1_Failed_Event :: struct {
	object: Image_Copy_Capture_Frame_V1,
	reason: Image_Copy_Capture_Frame_V1_Failure_Reason,
}
Image_Copy_Capture_Cursor_Session_V1_Enter_Event :: struct {
	object: Image_Copy_Capture_Cursor_Session_V1,
}
Image_Copy_Capture_Cursor_Session_V1_Leave_Event :: struct {
	object: Image_Copy_Capture_Cursor_Session_V1,
}
Image_Copy_Capture_Cursor_Session_V1_Position_Event :: struct {
	object: Image_Copy_Capture_Cursor_Session_V1,
	x: i32,
	y: i32,
}
Image_Copy_Capture_Cursor_Session_V1_Hotspot_Event :: struct {
	object: Image_Copy_Capture_Cursor_Session_V1,
	x: i32,
	y: i32,
}

read_foreign_toplevel_list_v1_toplevel :: proc(object: u32) -> Foreign_Toplevel_List_V1_Toplevel_Event {
	event: Foreign_Toplevel_List_V1_Toplevel_Event = ---
	event.object = Foreign_Toplevel_List_V1(object)
	read(cast(^u32)&event.toplevel)
	connection.server_object_types[u32(event.toplevel) - SERVER_ID_START] = Foreign_Toplevel_Handle_V1
	return event
}
read_foreign_toplevel_list_v1_finished :: proc(object: u32) -> Foreign_Toplevel_List_V1_Finished_Event {
	event: Foreign_Toplevel_List_V1_Finished_Event = ---
	event.object = Foreign_Toplevel_List_V1(object)
	return event
}
read_foreign_toplevel_handle_v1_closed :: proc(object: u32) -> Foreign_Toplevel_Handle_V1_Closed_Event {
	event: Foreign_Toplevel_Handle_V1_Closed_Event = ---
	event.object = Foreign_Toplevel_Handle_V1(object)
	return event
}
read_foreign_toplevel_handle_v1_done :: proc(object: u32) -> Foreign_Toplevel_Handle_V1_Done_Event {
	event: Foreign_Toplevel_Handle_V1_Done_Event = ---
	event.object = Foreign_Toplevel_Handle_V1(object)
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
read_foreign_toplevel_handle_v1_identifier :: proc(object: u32) -> Foreign_Toplevel_Handle_V1_Identifier_Event {
	event: Foreign_Toplevel_Handle_V1_Identifier_Event = ---
	event.object = Foreign_Toplevel_Handle_V1(object)
	read(&event.identifier)
	return event
}
read_image_copy_capture_session_v1_buffer_size :: proc(object: u32) -> Image_Copy_Capture_Session_V1_Buffer_Size_Event {
	event: Image_Copy_Capture_Session_V1_Buffer_Size_Event = ---
	event.object = Image_Copy_Capture_Session_V1(object)
	read(&event.width)
	read(&event.height)
	return event
}
read_image_copy_capture_session_v1_shm_format :: proc(object: u32) -> Image_Copy_Capture_Session_V1_Shm_Format_Event {
	event: Image_Copy_Capture_Session_V1_Shm_Format_Event = ---
	event.object = Image_Copy_Capture_Session_V1(object)
	read(cast(^u32)&event.format)
	return event
}
read_image_copy_capture_session_v1_dmabuf_device :: proc(object: u32) -> Image_Copy_Capture_Session_V1_Dmabuf_Device_Event {
	event: Image_Copy_Capture_Session_V1_Dmabuf_Device_Event = ---
	event.object = Image_Copy_Capture_Session_V1(object)
	read(&event.device)
	return event
}
read_image_copy_capture_session_v1_dmabuf_format :: proc(object: u32) -> Image_Copy_Capture_Session_V1_Dmabuf_Format_Event {
	event: Image_Copy_Capture_Session_V1_Dmabuf_Format_Event = ---
	event.object = Image_Copy_Capture_Session_V1(object)
	read(&event.format)
	read(&event.modifiers)
	return event
}
read_image_copy_capture_session_v1_done :: proc(object: u32) -> Image_Copy_Capture_Session_V1_Done_Event {
	event: Image_Copy_Capture_Session_V1_Done_Event = ---
	event.object = Image_Copy_Capture_Session_V1(object)
	return event
}
read_image_copy_capture_session_v1_stopped :: proc(object: u32) -> Image_Copy_Capture_Session_V1_Stopped_Event {
	event: Image_Copy_Capture_Session_V1_Stopped_Event = ---
	event.object = Image_Copy_Capture_Session_V1(object)
	return event
}
read_image_copy_capture_frame_v1_transform :: proc(object: u32) -> Image_Copy_Capture_Frame_V1_Transform_Event {
	event: Image_Copy_Capture_Frame_V1_Transform_Event = ---
	event.object = Image_Copy_Capture_Frame_V1(object)
	read(cast(^u32)&event.transform)
	return event
}
read_image_copy_capture_frame_v1_damage :: proc(object: u32) -> Image_Copy_Capture_Frame_V1_Damage_Event {
	event: Image_Copy_Capture_Frame_V1_Damage_Event = ---
	event.object = Image_Copy_Capture_Frame_V1(object)
	read(&event.x)
	read(&event.y)
	read(&event.width)
	read(&event.height)
	return event
}
read_image_copy_capture_frame_v1_presentation_time :: proc(object: u32) -> Image_Copy_Capture_Frame_V1_Presentation_Time_Event {
	event: Image_Copy_Capture_Frame_V1_Presentation_Time_Event = ---
	event.object = Image_Copy_Capture_Frame_V1(object)
	read(&event.tv_sec_hi)
	read(&event.tv_sec_lo)
	read(&event.tv_nsec)
	return event
}
read_image_copy_capture_frame_v1_ready :: proc(object: u32) -> Image_Copy_Capture_Frame_V1_Ready_Event {
	event: Image_Copy_Capture_Frame_V1_Ready_Event = ---
	event.object = Image_Copy_Capture_Frame_V1(object)
	return event
}
read_image_copy_capture_frame_v1_failed :: proc(object: u32) -> Image_Copy_Capture_Frame_V1_Failed_Event {
	event: Image_Copy_Capture_Frame_V1_Failed_Event = ---
	event.object = Image_Copy_Capture_Frame_V1(object)
	read(cast(^u32)&event.reason)
	return event
}
read_image_copy_capture_cursor_session_v1_enter :: proc(object: u32) -> Image_Copy_Capture_Cursor_Session_V1_Enter_Event {
	event: Image_Copy_Capture_Cursor_Session_V1_Enter_Event = ---
	event.object = Image_Copy_Capture_Cursor_Session_V1(object)
	return event
}
read_image_copy_capture_cursor_session_v1_leave :: proc(object: u32) -> Image_Copy_Capture_Cursor_Session_V1_Leave_Event {
	event: Image_Copy_Capture_Cursor_Session_V1_Leave_Event = ---
	event.object = Image_Copy_Capture_Cursor_Session_V1(object)
	return event
}
read_image_copy_capture_cursor_session_v1_position :: proc(object: u32) -> Image_Copy_Capture_Cursor_Session_V1_Position_Event {
	event: Image_Copy_Capture_Cursor_Session_V1_Position_Event = ---
	event.object = Image_Copy_Capture_Cursor_Session_V1(object)
	read(&event.x)
	read(&event.y)
	return event
}
read_image_copy_capture_cursor_session_v1_hotspot :: proc(object: u32) -> Image_Copy_Capture_Cursor_Session_V1_Hotspot_Event {
	event: Image_Copy_Capture_Cursor_Session_V1_Hotspot_Event = ---
	event.object = Image_Copy_Capture_Cursor_Session_V1(object)
	read(&event.x)
	read(&event.y)
	return event
}

foreign_toplevel_list_v1_stop :: proc(_object: Foreign_Toplevel_List_V1) {
	_object := cast(u32)_object
	_opcode: u16 = 0
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
foreign_toplevel_list_v1_destroy :: proc(_object: Foreign_Toplevel_List_V1) {
	_object := cast(u32)_object
	_opcode: u16 = 1
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
foreign_toplevel_handle_v1_destroy :: proc(_object: Foreign_Toplevel_Handle_V1) {
	_object := cast(u32)_object
	_opcode: u16 = 0
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
image_capture_source_v1_destroy :: proc(_object: Image_Capture_Source_V1) {
	_object := cast(u32)_object
	_opcode: u16 = 0
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
output_image_capture_source_manager_v1_create_source :: proc(_object: Output_Image_Capture_Source_Manager_V1, output: wl.Output) -> Image_Capture_Source_V1 {
	_id := generate_id(Image_Capture_Source_V1)
	output := cast(u32)output
	_object := cast(u32)_object
	_opcode: u16 = 0
	_size: u16 = 8 + size_of(_id) + size_of(output)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&_id)
	write(&output)
	return Image_Capture_Source_V1(_id)
}
output_image_capture_source_manager_v1_destroy :: proc(_object: Output_Image_Capture_Source_Manager_V1) {
	_object := cast(u32)_object
	_opcode: u16 = 1
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
foreign_toplevel_image_capture_source_manager_v1_create_source :: proc(_object: Foreign_Toplevel_Image_Capture_Source_Manager_V1, toplevel_handle: Foreign_Toplevel_Handle_V1) -> Image_Capture_Source_V1 {
	_id := generate_id(Image_Capture_Source_V1)
	toplevel_handle := cast(u32)toplevel_handle
	_object := cast(u32)_object
	_opcode: u16 = 0
	_size: u16 = 8 + size_of(_id) + size_of(toplevel_handle)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&_id)
	write(&toplevel_handle)
	return Image_Capture_Source_V1(_id)
}
foreign_toplevel_image_capture_source_manager_v1_destroy :: proc(_object: Foreign_Toplevel_Image_Capture_Source_Manager_V1) {
	_object := cast(u32)_object
	_opcode: u16 = 1
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
image_copy_capture_manager_v1_create_session :: proc(_object: Image_Copy_Capture_Manager_V1, source: Image_Capture_Source_V1, options: Image_Copy_Capture_Manager_V1_Options) -> Image_Copy_Capture_Session_V1 {
	_id := generate_id(Image_Copy_Capture_Session_V1)
	source := cast(u32)source
	options := cast(u32)options
	_object := cast(u32)_object
	_opcode: u16 = 0
	_size: u16 = 8 + size_of(_id) + size_of(source) + size_of(options)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&_id)
	write(&source)
	write(&options)
	return Image_Copy_Capture_Session_V1(_id)
}
image_copy_capture_manager_v1_create_pointer_cursor_session :: proc(_object: Image_Copy_Capture_Manager_V1, source: Image_Capture_Source_V1, pointer: wl.Pointer) -> Image_Copy_Capture_Cursor_Session_V1 {
	_id := generate_id(Image_Copy_Capture_Cursor_Session_V1)
	source := cast(u32)source
	pointer := cast(u32)pointer
	_object := cast(u32)_object
	_opcode: u16 = 1
	_size: u16 = 8 + size_of(_id) + size_of(source) + size_of(pointer)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&_id)
	write(&source)
	write(&pointer)
	return Image_Copy_Capture_Cursor_Session_V1(_id)
}
image_copy_capture_manager_v1_destroy :: proc(_object: Image_Copy_Capture_Manager_V1) {
	_object := cast(u32)_object
	_opcode: u16 = 2
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
image_copy_capture_session_v1_create_frame :: proc(_object: Image_Copy_Capture_Session_V1) -> Image_Copy_Capture_Frame_V1 {
	_id := generate_id(Image_Copy_Capture_Frame_V1)
	_object := cast(u32)_object
	_opcode: u16 = 0
	_size: u16 = 8 + size_of(_id)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&_id)
	return Image_Copy_Capture_Frame_V1(_id)
}
image_copy_capture_session_v1_destroy :: proc(_object: Image_Copy_Capture_Session_V1) {
	_object := cast(u32)_object
	_opcode: u16 = 1
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
image_copy_capture_frame_v1_destroy :: proc(_object: Image_Copy_Capture_Frame_V1) {
	_object := cast(u32)_object
	_opcode: u16 = 0
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
image_copy_capture_frame_v1_attach_buffer :: proc(_object: Image_Copy_Capture_Frame_V1, buffer: wl.Buffer) {
	buffer := cast(u32)buffer
	_object := cast(u32)_object
	_opcode: u16 = 1
	_size: u16 = 8 + size_of(buffer)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&buffer)
}
image_copy_capture_frame_v1_damage_buffer :: proc(_object: Image_Copy_Capture_Frame_V1, x: i32, y: i32, width: i32, height: i32) {
	x := x
	y := y
	width := width
	height := height
	_object := cast(u32)_object
	_opcode: u16 = 2
	_size: u16 = 8 + size_of(x) + size_of(y) + size_of(width) + size_of(height)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&x)
	write(&y)
	write(&width)
	write(&height)
}
image_copy_capture_frame_v1_capture :: proc(_object: Image_Copy_Capture_Frame_V1) {
	_object := cast(u32)_object
	_opcode: u16 = 3
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
image_copy_capture_cursor_session_v1_destroy :: proc(_object: Image_Copy_Capture_Cursor_Session_V1) {
	_object := cast(u32)_object
	_opcode: u16 = 0
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
image_copy_capture_cursor_session_v1_get_capture_session :: proc(_object: Image_Copy_Capture_Cursor_Session_V1) -> Image_Copy_Capture_Session_V1 {
	_id := generate_id(Image_Copy_Capture_Session_V1)
	_object := cast(u32)_object
	_opcode: u16 = 1
	_size: u16 = 8 + size_of(_id)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&_id)
	return Image_Copy_Capture_Session_V1(_id)
}

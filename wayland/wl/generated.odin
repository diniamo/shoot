package wayland_wl

import "base:runtime"
import common "../common"


Object     :: common.Object
Fd         :: common.Fd
Fixed      :: i32

SERVER_ID_START :: common.SERVER_ID_START

connection := &common.connection

generate_id :: common.generate_id
read        :: common.read
write       :: common.write

DISPLAY_INTERFACE :: "wl_display"
REGISTRY_INTERFACE :: "wl_registry"
CALLBACK_INTERFACE :: "wl_callback"
COMPOSITOR_INTERFACE :: "wl_compositor"
SHM_POOL_INTERFACE :: "wl_shm_pool"
SHM_INTERFACE :: "wl_shm"
BUFFER_INTERFACE :: "wl_buffer"
DATA_OFFER_INTERFACE :: "wl_data_offer"
DATA_SOURCE_INTERFACE :: "wl_data_source"
DATA_DEVICE_INTERFACE :: "wl_data_device"
DATA_DEVICE_MANAGER_INTERFACE :: "wl_data_device_manager"
SHELL_INTERFACE :: "wl_shell"
SHELL_SURFACE_INTERFACE :: "wl_shell_surface"
SURFACE_INTERFACE :: "wl_surface"
SEAT_INTERFACE :: "wl_seat"
POINTER_INTERFACE :: "wl_pointer"
KEYBOARD_INTERFACE :: "wl_keyboard"
TOUCH_INTERFACE :: "wl_touch"
OUTPUT_INTERFACE :: "wl_output"
REGION_INTERFACE :: "wl_region"
SUBCOMPOSITOR_INTERFACE :: "wl_subcompositor"
SUBSURFACE_INTERFACE :: "wl_subsurface"
FIXES_INTERFACE :: "wl_fixes"

Display :: distinct u32
Registry :: distinct u32
Callback :: distinct u32
Compositor :: distinct u32
Shm_Pool :: distinct u32
Shm :: distinct u32
Buffer :: distinct u32
Data_Offer :: distinct u32
Data_Source :: distinct u32
Data_Device :: distinct u32
Data_Device_Manager :: distinct u32
Shell :: distinct u32
Shell_Surface :: distinct u32
Surface :: distinct u32
Seat :: distinct u32
Pointer :: distinct u32
Keyboard :: distinct u32
Touch :: distinct u32
Output :: distinct u32
Region :: distinct u32
Subcompositor :: distinct u32
Subsurface :: distinct u32
Fixes :: distinct u32

Display_Error :: enum u32 {
	Invalid_Object = 0,
	Invalid_Method = 1,
	No_Memory = 2,
	Implementation = 3,
}
Shm_Error :: enum u32 {
	Invalid_Format = 0,
	Invalid_Stride = 1,
	Invalid_Fd = 2,
}
Shm_Format :: enum u32 {
	Argb8888 = 0,
	Xrgb8888 = 1,
	C8 = 0x20203843,
	Rgb332 = 0x38424752,
	Bgr233 = 0x38524742,
	Xrgb4444 = 0x32315258,
	Xbgr4444 = 0x32314258,
	Rgbx4444 = 0x32315852,
	Bgrx4444 = 0x32315842,
	Argb4444 = 0x32315241,
	Abgr4444 = 0x32314241,
	Rgba4444 = 0x32314152,
	Bgra4444 = 0x32314142,
	Xrgb1555 = 0x35315258,
	Xbgr1555 = 0x35314258,
	Rgbx5551 = 0x35315852,
	Bgrx5551 = 0x35315842,
	Argb1555 = 0x35315241,
	Abgr1555 = 0x35314241,
	Rgba5551 = 0x35314152,
	Bgra5551 = 0x35314142,
	Rgb565 = 0x36314752,
	Bgr565 = 0x36314742,
	Rgb888 = 0x34324752,
	Bgr888 = 0x34324742,
	Xbgr8888 = 0x34324258,
	Rgbx8888 = 0x34325852,
	Bgrx8888 = 0x34325842,
	Abgr8888 = 0x34324241,
	Rgba8888 = 0x34324152,
	Bgra8888 = 0x34324142,
	Xrgb2101010 = 0x30335258,
	Xbgr2101010 = 0x30334258,
	Rgbx1010102 = 0x30335852,
	Bgrx1010102 = 0x30335842,
	Argb2101010 = 0x30335241,
	Abgr2101010 = 0x30334241,
	Rgba1010102 = 0x30334152,
	Bgra1010102 = 0x30334142,
	Yuyv = 0x56595559,
	Yvyu = 0x55595659,
	Uyvy = 0x59565955,
	Vyuy = 0x59555956,
	Ayuv = 0x56555941,
	Nv12 = 0x3231564e,
	Nv21 = 0x3132564e,
	Nv16 = 0x3631564e,
	Nv61 = 0x3136564e,
	Yuv410 = 0x39565559,
	Yvu410 = 0x39555659,
	Yuv411 = 0x31315559,
	Yvu411 = 0x31315659,
	Yuv420 = 0x32315559,
	Yvu420 = 0x32315659,
	Yuv422 = 0x36315559,
	Yvu422 = 0x36315659,
	Yuv444 = 0x34325559,
	Yvu444 = 0x34325659,
	R8 = 0x20203852,
	R16 = 0x20363152,
	Rg88 = 0x38384752,
	Gr88 = 0x38385247,
	Rg1616 = 0x32334752,
	Gr1616 = 0x32335247,
	Xrgb16161616f = 0x48345258,
	Xbgr16161616f = 0x48344258,
	Argb16161616f = 0x48345241,
	Abgr16161616f = 0x48344241,
	Xyuv8888 = 0x56555958,
	Vuy888 = 0x34325556,
	Vuy101010 = 0x30335556,
	Y210 = 0x30313259,
	Y212 = 0x32313259,
	Y216 = 0x36313259,
	Y410 = 0x30313459,
	Y412 = 0x32313459,
	Y416 = 0x36313459,
	Xvyu2101010 = 0x30335658,
	Xvyu12_16161616 = 0x36335658,
	Xvyu16161616 = 0x38345658,
	Y0l0 = 0x304c3059,
	X0l0 = 0x304c3058,
	Y0l2 = 0x324c3059,
	X0l2 = 0x324c3058,
	Yuv420_8bit = 0x38305559,
	Yuv420_10bit = 0x30315559,
	Xrgb8888_A8 = 0x38415258,
	Xbgr8888_A8 = 0x38414258,
	Rgbx8888_A8 = 0x38415852,
	Bgrx8888_A8 = 0x38415842,
	Rgb888_A8 = 0x38413852,
	Bgr888_A8 = 0x38413842,
	Rgb565_A8 = 0x38413552,
	Bgr565_A8 = 0x38413542,
	Nv24 = 0x3432564e,
	Nv42 = 0x3234564e,
	P210 = 0x30313250,
	P010 = 0x30313050,
	P012 = 0x32313050,
	P016 = 0x36313050,
	Axbxgxrx106106106106 = 0x30314241,
	Nv15 = 0x3531564e,
	Q410 = 0x30313451,
	Q401 = 0x31303451,
	Xrgb16161616 = 0x38345258,
	Xbgr16161616 = 0x38344258,
	Argb16161616 = 0x38345241,
	Abgr16161616 = 0x38344241,
	C1 = 0x20203143,
	C2 = 0x20203243,
	C4 = 0x20203443,
	D1 = 0x20203144,
	D2 = 0x20203244,
	D4 = 0x20203444,
	D8 = 0x20203844,
	R1 = 0x20203152,
	R2 = 0x20203252,
	R4 = 0x20203452,
	R10 = 0x20303152,
	R12 = 0x20323152,
	Avuy8888 = 0x59555641,
	Xvuy8888 = 0x59555658,
	P030 = 0x30333050,
	Rgb161616 = 0x38344752,
	Bgr161616 = 0x38344742,
	R16f = 0x48202052,
	Gr1616f = 0x48205247,
	Bgr161616f = 0x48524742,
	R32f = 0x46202052,
	Gr3232f = 0x46205247,
	Bgr323232f = 0x46524742,
	Abgr32323232f = 0x46384241,
	Nv20 = 0x3032564e,
	Nv30 = 0x3033564e,
	S010 = 0x30313053,
	S210 = 0x30313253,
	S410 = 0x30313453,
	S012 = 0x32313053,
	S212 = 0x32313253,
	S412 = 0x32313453,
	S016 = 0x36313053,
	S216 = 0x36313253,
	S416 = 0x36313453,
}
Data_Offer_Error :: enum u32 {
	Invalid_Finish = 0,
	Invalid_Action_Mask = 1,
	Invalid_Action = 2,
	Invalid_Offer = 3,
}
Data_Source_Error :: enum u32 {
	Invalid_Action_Mask = 0,
	Invalid_Source = 1,
}
Data_Device_Error :: enum u32 {
	Role = 0,
	Used_Source = 1,
}
Data_Device_Manager_Dnd_Action :: enum u32 {
	None = 0,
	Copy = 1,
	Move = 2,
	Ask = 4,
}
Shell_Error :: enum u32 {
	Role = 0,
}
Shell_Surface_Resize :: enum u32 {
	None = 0,
	Top = 1,
	Bottom = 2,
	Left = 4,
	Top_Left = 5,
	Bottom_Left = 6,
	Right = 8,
	Top_Right = 9,
	Bottom_Right = 10,
}
Shell_Surface_Transient :: enum u32 {
	Inactive = 0x1,
}
Shell_Surface_Fullscreen_Method :: enum u32 {
	Default = 0,
	Scale = 1,
	Driver = 2,
	Fill = 3,
}
Surface_Error :: enum u32 {
	Invalid_Scale = 0,
	Invalid_Transform = 1,
	Invalid_Size = 2,
	Invalid_Offset = 3,
	Defunct_Role_Object = 4,
	No_Buffer = 5,
}
Seat_Capability :: enum u32 {
	Pointer = 1,
	Keyboard = 2,
	Touch = 4,
}
Seat_Error :: enum u32 {
	Missing_Capability = 0,
}
Pointer_Error :: enum u32 {
	Role = 0,
}
Pointer_Button_State :: enum u32 {
	Released = 0,
	Pressed = 1,
}
Pointer_Axis :: enum u32 {
	Vertical_Scroll = 0,
	Horizontal_Scroll = 1,
}
Pointer_Axis_Source :: enum u32 {
	Wheel = 0,
	Finger = 1,
	Continuous = 2,
	Wheel_Tilt = 3,
}
Pointer_Axis_Relative_Direction :: enum u32 {
	Identical = 0,
	Inverted = 1,
}
Keyboard_Keymap_Format :: enum u32 {
	No_Keymap = 0,
	Xkb_V1 = 1,
}
Keyboard_Key_State :: enum u32 {
	Released = 0,
	Pressed = 1,
	Repeated = 2,
}
Output_Subpixel :: enum u32 {
	Unknown = 0,
	None = 1,
	Horizontal_Rgb = 2,
	Horizontal_Bgr = 3,
	Vertical_Rgb = 4,
	Vertical_Bgr = 5,
}
Output_Transform :: enum u32 {
	Normal = 0,
	_90 = 1,
	_180 = 2,
	_270 = 3,
	Flipped = 4,
	Flipped_90 = 5,
	Flipped_180 = 6,
	Flipped_270 = 7,
}
Output_Mode :: enum u32 {
	Current = 0x1,
	Preferred = 0x2,
}
Subcompositor_Error :: enum u32 {
	Bad_Surface = 0,
	Bad_Parent = 1,
}
Subsurface_Error :: enum u32 {
	Bad_Surface = 0,
}

Display_Error_Event :: struct {
	object: Display,
	object_id: Object,
	code: u32,
	message: string,
}
Display_Delete_Id_Event :: struct {
	object: Display,
	id: u32,
}
Registry_Global_Event :: struct {
	object: Registry,
	name: u32,
	interface: string,
	version: u32,
}
Registry_Global_Remove_Event :: struct {
	object: Registry,
	name: u32,
}
Callback_Done_Event :: struct {
	object: Callback,
	callback_data: u32,
}
Shm_Format_Event :: struct {
	object: Shm,
	format: Shm_Format,
}
Buffer_Release_Event :: struct {
	object: Buffer,
}
Data_Offer_Offer_Event :: struct {
	object: Data_Offer,
	mime_type: string,
}
Data_Offer_Source_Actions_Event :: struct {
	object: Data_Offer,
	source_actions: Data_Device_Manager_Dnd_Action,
}
Data_Offer_Action_Event :: struct {
	object: Data_Offer,
	dnd_action: Data_Device_Manager_Dnd_Action,
}
Data_Source_Target_Event :: struct {
	object: Data_Source,
	mime_type: string,
}
Data_Source_Send_Event :: struct {
	object: Data_Source,
	mime_type: string,
	fd: Fd,
}
Data_Source_Cancelled_Event :: struct {
	object: Data_Source,
}
Data_Source_Dnd_Drop_Performed_Event :: struct {
	object: Data_Source,
}
Data_Source_Dnd_Finished_Event :: struct {
	object: Data_Source,
}
Data_Source_Action_Event :: struct {
	object: Data_Source,
	dnd_action: Data_Device_Manager_Dnd_Action,
}
Data_Device_Data_Offer_Event :: struct {
	object: Data_Device,
	id: Data_Offer,
}
Data_Device_Enter_Event :: struct {
	object: Data_Device,
	serial: u32,
	surface: Surface,
	x: f64,
	y: f64,
	id: Data_Offer,
}
Data_Device_Leave_Event :: struct {
	object: Data_Device,
}
Data_Device_Motion_Event :: struct {
	object: Data_Device,
	time: u32,
	x: f64,
	y: f64,
}
Data_Device_Drop_Event :: struct {
	object: Data_Device,
}
Data_Device_Selection_Event :: struct {
	object: Data_Device,
	id: Data_Offer,
}
Shell_Surface_Ping_Event :: struct {
	object: Shell_Surface,
	serial: u32,
}
Shell_Surface_Configure_Event :: struct {
	object: Shell_Surface,
	edges: Shell_Surface_Resize,
	width: i32,
	height: i32,
}
Shell_Surface_Popup_Done_Event :: struct {
	object: Shell_Surface,
}
Surface_Enter_Event :: struct {
	object: Surface,
	output: Output,
}
Surface_Leave_Event :: struct {
	object: Surface,
	output: Output,
}
Surface_Preferred_Buffer_Scale_Event :: struct {
	object: Surface,
	factor: i32,
}
Surface_Preferred_Buffer_Transform_Event :: struct {
	object: Surface,
	transform: Output_Transform,
}
Seat_Capabilities_Event :: struct {
	object: Seat,
	capabilities: Seat_Capability,
}
Seat_Name_Event :: struct {
	object: Seat,
	name: string,
}
Pointer_Enter_Event :: struct {
	object: Pointer,
	serial: u32,
	surface: Surface,
	surface_x: f64,
	surface_y: f64,
}
Pointer_Leave_Event :: struct {
	object: Pointer,
	serial: u32,
	surface: Surface,
}
Pointer_Motion_Event :: struct {
	object: Pointer,
	time: u32,
	surface_x: f64,
	surface_y: f64,
}
Pointer_Button_Event :: struct {
	object: Pointer,
	serial: u32,
	time: u32,
	button: u32,
	state: Pointer_Button_State,
}
Pointer_Axis_Event :: struct {
	object: Pointer,
	time: u32,
	axis: Pointer_Axis,
	value: f64,
}
Pointer_Frame_Event :: struct {
	object: Pointer,
}
Pointer_Axis_Source_Event :: struct {
	object: Pointer,
	axis_source: Pointer_Axis_Source,
}
Pointer_Axis_Stop_Event :: struct {
	object: Pointer,
	time: u32,
	axis: Pointer_Axis,
}
Pointer_Axis_Discrete_Event :: struct {
	object: Pointer,
	axis: Pointer_Axis,
	discrete: i32,
}
Pointer_Axis_Value120_Event :: struct {
	object: Pointer,
	axis: Pointer_Axis,
	value120: i32,
}
Pointer_Axis_Relative_Direction_Event :: struct {
	object: Pointer,
	axis: Pointer_Axis,
	direction: Pointer_Axis_Relative_Direction,
}
Keyboard_Keymap_Event :: struct {
	object: Keyboard,
	format: Keyboard_Keymap_Format,
	fd: Fd,
	size: u32,
}
Keyboard_Enter_Event :: struct {
	object: Keyboard,
	serial: u32,
	surface: Surface,
	keys: []byte,
}
Keyboard_Leave_Event :: struct {
	object: Keyboard,
	serial: u32,
	surface: Surface,
}
Keyboard_Key_Event :: struct {
	object: Keyboard,
	serial: u32,
	time: u32,
	key: u32,
	state: Keyboard_Key_State,
}
Keyboard_Modifiers_Event :: struct {
	object: Keyboard,
	serial: u32,
	mods_depressed: u32,
	mods_latched: u32,
	mods_locked: u32,
	group: u32,
}
Keyboard_Repeat_Info_Event :: struct {
	object: Keyboard,
	rate: i32,
	delay: i32,
}
Touch_Down_Event :: struct {
	object: Touch,
	serial: u32,
	time: u32,
	surface: Surface,
	id: i32,
	x: f64,
	y: f64,
}
Touch_Up_Event :: struct {
	object: Touch,
	serial: u32,
	time: u32,
	id: i32,
}
Touch_Motion_Event :: struct {
	object: Touch,
	time: u32,
	id: i32,
	x: f64,
	y: f64,
}
Touch_Frame_Event :: struct {
	object: Touch,
}
Touch_Cancel_Event :: struct {
	object: Touch,
}
Touch_Shape_Event :: struct {
	object: Touch,
	id: i32,
	major: f64,
	minor: f64,
}
Touch_Orientation_Event :: struct {
	object: Touch,
	id: i32,
	orientation: f64,
}
Output_Geometry_Event :: struct {
	object: Output,
	x: i32,
	y: i32,
	physical_width: i32,
	physical_height: i32,
	subpixel: i32,
	make: string,
	model: string,
	transform: i32,
}
Output_Mode_Event :: struct {
	object: Output,
	flags: Output_Mode,
	width: i32,
	height: i32,
	refresh: i32,
}
Output_Done_Event :: struct {
	object: Output,
}
Output_Scale_Event :: struct {
	object: Output,
	factor: i32,
}
Output_Name_Event :: struct {
	object: Output,
	name: string,
}
Output_Description_Event :: struct {
	object: Output,
	description: string,
}

read_display_error :: proc(object: u32) -> Display_Error_Event {
	event: Display_Error_Event = ---
	event.object = Display(object)
	read(cast(^u32)&event.object_id)
	read(&event.code)
	read(&event.message)
	return event
}
read_display_delete_id :: proc(object: u32) -> Display_Delete_Id_Event {
	event: Display_Delete_Id_Event = ---
	event.object = Display(object)
	read(&event.id)
	return event
}
read_registry_global :: proc(object: u32) -> Registry_Global_Event {
	event: Registry_Global_Event = ---
	event.object = Registry(object)
	read(&event.name)
	read(&event.interface)
	read(&event.version)
	return event
}
read_registry_global_remove :: proc(object: u32) -> Registry_Global_Remove_Event {
	event: Registry_Global_Remove_Event = ---
	event.object = Registry(object)
	read(&event.name)
	return event
}
read_callback_done :: proc(object: u32) -> Callback_Done_Event {
	event: Callback_Done_Event = ---
	event.object = Callback(object)
	read(&event.callback_data)
	return event
}
read_shm_format :: proc(object: u32) -> Shm_Format_Event {
	event: Shm_Format_Event = ---
	event.object = Shm(object)
	read(cast(^u32)&event.format)
	return event
}
read_buffer_release :: proc(object: u32) -> Buffer_Release_Event {
	event: Buffer_Release_Event = ---
	event.object = Buffer(object)
	return event
}
read_data_offer_offer :: proc(object: u32) -> Data_Offer_Offer_Event {
	event: Data_Offer_Offer_Event = ---
	event.object = Data_Offer(object)
	read(&event.mime_type)
	return event
}
read_data_offer_source_actions :: proc(object: u32) -> Data_Offer_Source_Actions_Event {
	event: Data_Offer_Source_Actions_Event = ---
	event.object = Data_Offer(object)
	read(cast(^u32)&event.source_actions)
	return event
}
read_data_offer_action :: proc(object: u32) -> Data_Offer_Action_Event {
	event: Data_Offer_Action_Event = ---
	event.object = Data_Offer(object)
	read(cast(^u32)&event.dnd_action)
	return event
}
read_data_source_target :: proc(object: u32) -> Data_Source_Target_Event {
	event: Data_Source_Target_Event = ---
	event.object = Data_Source(object)
	read(&event.mime_type)
	return event
}
read_data_source_send :: proc(object: u32) -> Data_Source_Send_Event {
	event: Data_Source_Send_Event = ---
	event.object = Data_Source(object)
	read(&event.mime_type)
	read(&event.fd)
	return event
}
read_data_source_cancelled :: proc(object: u32) -> Data_Source_Cancelled_Event {
	event: Data_Source_Cancelled_Event = ---
	event.object = Data_Source(object)
	return event
}
read_data_source_dnd_drop_performed :: proc(object: u32) -> Data_Source_Dnd_Drop_Performed_Event {
	event: Data_Source_Dnd_Drop_Performed_Event = ---
	event.object = Data_Source(object)
	return event
}
read_data_source_dnd_finished :: proc(object: u32) -> Data_Source_Dnd_Finished_Event {
	event: Data_Source_Dnd_Finished_Event = ---
	event.object = Data_Source(object)
	return event
}
read_data_source_action :: proc(object: u32) -> Data_Source_Action_Event {
	event: Data_Source_Action_Event = ---
	event.object = Data_Source(object)
	read(cast(^u32)&event.dnd_action)
	return event
}
read_data_device_data_offer :: proc(object: u32) -> Data_Device_Data_Offer_Event {
	event: Data_Device_Data_Offer_Event = ---
	event.object = Data_Device(object)
	read(cast(^u32)&event.id)
	connection.server_object_types[u32(event.id) - SERVER_ID_START] = Data_Offer
	return event
}
read_data_device_enter :: proc(object: u32) -> Data_Device_Enter_Event {
	event: Data_Device_Enter_Event = ---
	event.object = Data_Device(object)
	read(&event.serial)
	read(cast(^u32)&event.surface)
	read(&event.x)
	read(&event.y)
	read(cast(^u32)&event.id)
	return event
}
read_data_device_leave :: proc(object: u32) -> Data_Device_Leave_Event {
	event: Data_Device_Leave_Event = ---
	event.object = Data_Device(object)
	return event
}
read_data_device_motion :: proc(object: u32) -> Data_Device_Motion_Event {
	event: Data_Device_Motion_Event = ---
	event.object = Data_Device(object)
	read(&event.time)
	read(&event.x)
	read(&event.y)
	return event
}
read_data_device_drop :: proc(object: u32) -> Data_Device_Drop_Event {
	event: Data_Device_Drop_Event = ---
	event.object = Data_Device(object)
	return event
}
read_data_device_selection :: proc(object: u32) -> Data_Device_Selection_Event {
	event: Data_Device_Selection_Event = ---
	event.object = Data_Device(object)
	read(cast(^u32)&event.id)
	return event
}
read_shell_surface_ping :: proc(object: u32) -> Shell_Surface_Ping_Event {
	event: Shell_Surface_Ping_Event = ---
	event.object = Shell_Surface(object)
	read(&event.serial)
	return event
}
read_shell_surface_configure :: proc(object: u32) -> Shell_Surface_Configure_Event {
	event: Shell_Surface_Configure_Event = ---
	event.object = Shell_Surface(object)
	read(cast(^u32)&event.edges)
	read(&event.width)
	read(&event.height)
	return event
}
read_shell_surface_popup_done :: proc(object: u32) -> Shell_Surface_Popup_Done_Event {
	event: Shell_Surface_Popup_Done_Event = ---
	event.object = Shell_Surface(object)
	return event
}
read_surface_enter :: proc(object: u32) -> Surface_Enter_Event {
	event: Surface_Enter_Event = ---
	event.object = Surface(object)
	read(cast(^u32)&event.output)
	return event
}
read_surface_leave :: proc(object: u32) -> Surface_Leave_Event {
	event: Surface_Leave_Event = ---
	event.object = Surface(object)
	read(cast(^u32)&event.output)
	return event
}
read_surface_preferred_buffer_scale :: proc(object: u32) -> Surface_Preferred_Buffer_Scale_Event {
	event: Surface_Preferred_Buffer_Scale_Event = ---
	event.object = Surface(object)
	read(&event.factor)
	return event
}
read_surface_preferred_buffer_transform :: proc(object: u32) -> Surface_Preferred_Buffer_Transform_Event {
	event: Surface_Preferred_Buffer_Transform_Event = ---
	event.object = Surface(object)
	read(cast(^u32)&event.transform)
	return event
}
read_seat_capabilities :: proc(object: u32) -> Seat_Capabilities_Event {
	event: Seat_Capabilities_Event = ---
	event.object = Seat(object)
	read(cast(^u32)&event.capabilities)
	return event
}
read_seat_name :: proc(object: u32) -> Seat_Name_Event {
	event: Seat_Name_Event = ---
	event.object = Seat(object)
	read(&event.name)
	return event
}
read_pointer_enter :: proc(object: u32) -> Pointer_Enter_Event {
	event: Pointer_Enter_Event = ---
	event.object = Pointer(object)
	read(&event.serial)
	read(cast(^u32)&event.surface)
	read(&event.surface_x)
	read(&event.surface_y)
	return event
}
read_pointer_leave :: proc(object: u32) -> Pointer_Leave_Event {
	event: Pointer_Leave_Event = ---
	event.object = Pointer(object)
	read(&event.serial)
	read(cast(^u32)&event.surface)
	return event
}
read_pointer_motion :: proc(object: u32) -> Pointer_Motion_Event {
	event: Pointer_Motion_Event = ---
	event.object = Pointer(object)
	read(&event.time)
	read(&event.surface_x)
	read(&event.surface_y)
	return event
}
read_pointer_button :: proc(object: u32) -> Pointer_Button_Event {
	event: Pointer_Button_Event = ---
	event.object = Pointer(object)
	read(&event.serial)
	read(&event.time)
	read(&event.button)
	read(cast(^u32)&event.state)
	return event
}
read_pointer_axis :: proc(object: u32) -> Pointer_Axis_Event {
	event: Pointer_Axis_Event = ---
	event.object = Pointer(object)
	read(&event.time)
	read(cast(^u32)&event.axis)
	read(&event.value)
	return event
}
read_pointer_frame :: proc(object: u32) -> Pointer_Frame_Event {
	event: Pointer_Frame_Event = ---
	event.object = Pointer(object)
	return event
}
read_pointer_axis_source :: proc(object: u32) -> Pointer_Axis_Source_Event {
	event: Pointer_Axis_Source_Event = ---
	event.object = Pointer(object)
	read(cast(^u32)&event.axis_source)
	return event
}
read_pointer_axis_stop :: proc(object: u32) -> Pointer_Axis_Stop_Event {
	event: Pointer_Axis_Stop_Event = ---
	event.object = Pointer(object)
	read(&event.time)
	read(cast(^u32)&event.axis)
	return event
}
read_pointer_axis_discrete :: proc(object: u32) -> Pointer_Axis_Discrete_Event {
	event: Pointer_Axis_Discrete_Event = ---
	event.object = Pointer(object)
	read(cast(^u32)&event.axis)
	read(&event.discrete)
	return event
}
read_pointer_axis_value120 :: proc(object: u32) -> Pointer_Axis_Value120_Event {
	event: Pointer_Axis_Value120_Event = ---
	event.object = Pointer(object)
	read(cast(^u32)&event.axis)
	read(&event.value120)
	return event
}
read_pointer_axis_relative_direction :: proc(object: u32) -> Pointer_Axis_Relative_Direction_Event {
	event: Pointer_Axis_Relative_Direction_Event = ---
	event.object = Pointer(object)
	read(cast(^u32)&event.axis)
	read(cast(^u32)&event.direction)
	return event
}
read_keyboard_keymap :: proc(object: u32) -> Keyboard_Keymap_Event {
	event: Keyboard_Keymap_Event = ---
	event.object = Keyboard(object)
	read(cast(^u32)&event.format)
	read(&event.fd)
	read(&event.size)
	return event
}
read_keyboard_enter :: proc(object: u32) -> Keyboard_Enter_Event {
	event: Keyboard_Enter_Event = ---
	event.object = Keyboard(object)
	read(&event.serial)
	read(cast(^u32)&event.surface)
	read(&event.keys)
	return event
}
read_keyboard_leave :: proc(object: u32) -> Keyboard_Leave_Event {
	event: Keyboard_Leave_Event = ---
	event.object = Keyboard(object)
	read(&event.serial)
	read(cast(^u32)&event.surface)
	return event
}
read_keyboard_key :: proc(object: u32) -> Keyboard_Key_Event {
	event: Keyboard_Key_Event = ---
	event.object = Keyboard(object)
	read(&event.serial)
	read(&event.time)
	read(&event.key)
	read(cast(^u32)&event.state)
	return event
}
read_keyboard_modifiers :: proc(object: u32) -> Keyboard_Modifiers_Event {
	event: Keyboard_Modifiers_Event = ---
	event.object = Keyboard(object)
	read(&event.serial)
	read(&event.mods_depressed)
	read(&event.mods_latched)
	read(&event.mods_locked)
	read(&event.group)
	return event
}
read_keyboard_repeat_info :: proc(object: u32) -> Keyboard_Repeat_Info_Event {
	event: Keyboard_Repeat_Info_Event = ---
	event.object = Keyboard(object)
	read(&event.rate)
	read(&event.delay)
	return event
}
read_touch_down :: proc(object: u32) -> Touch_Down_Event {
	event: Touch_Down_Event = ---
	event.object = Touch(object)
	read(&event.serial)
	read(&event.time)
	read(cast(^u32)&event.surface)
	read(&event.id)
	read(&event.x)
	read(&event.y)
	return event
}
read_touch_up :: proc(object: u32) -> Touch_Up_Event {
	event: Touch_Up_Event = ---
	event.object = Touch(object)
	read(&event.serial)
	read(&event.time)
	read(&event.id)
	return event
}
read_touch_motion :: proc(object: u32) -> Touch_Motion_Event {
	event: Touch_Motion_Event = ---
	event.object = Touch(object)
	read(&event.time)
	read(&event.id)
	read(&event.x)
	read(&event.y)
	return event
}
read_touch_frame :: proc(object: u32) -> Touch_Frame_Event {
	event: Touch_Frame_Event = ---
	event.object = Touch(object)
	return event
}
read_touch_cancel :: proc(object: u32) -> Touch_Cancel_Event {
	event: Touch_Cancel_Event = ---
	event.object = Touch(object)
	return event
}
read_touch_shape :: proc(object: u32) -> Touch_Shape_Event {
	event: Touch_Shape_Event = ---
	event.object = Touch(object)
	read(&event.id)
	read(&event.major)
	read(&event.minor)
	return event
}
read_touch_orientation :: proc(object: u32) -> Touch_Orientation_Event {
	event: Touch_Orientation_Event = ---
	event.object = Touch(object)
	read(&event.id)
	read(&event.orientation)
	return event
}
read_output_geometry :: proc(object: u32) -> Output_Geometry_Event {
	event: Output_Geometry_Event = ---
	event.object = Output(object)
	read(&event.x)
	read(&event.y)
	read(&event.physical_width)
	read(&event.physical_height)
	read(&event.subpixel)
	read(&event.make)
	read(&event.model)
	read(&event.transform)
	return event
}
read_output_mode :: proc(object: u32) -> Output_Mode_Event {
	event: Output_Mode_Event = ---
	event.object = Output(object)
	read(cast(^u32)&event.flags)
	read(&event.width)
	read(&event.height)
	read(&event.refresh)
	return event
}
read_output_done :: proc(object: u32) -> Output_Done_Event {
	event: Output_Done_Event = ---
	event.object = Output(object)
	return event
}
read_output_scale :: proc(object: u32) -> Output_Scale_Event {
	event: Output_Scale_Event = ---
	event.object = Output(object)
	read(&event.factor)
	return event
}
read_output_name :: proc(object: u32) -> Output_Name_Event {
	event: Output_Name_Event = ---
	event.object = Output(object)
	read(&event.name)
	return event
}
read_output_description :: proc(object: u32) -> Output_Description_Event {
	event: Output_Description_Event = ---
	event.object = Output(object)
	read(&event.description)
	return event
}

display_sync :: proc(_object: Display) -> Callback {
	_id := generate_id(Callback)
	_object := cast(u32)_object
	_opcode: u16 = 0
	_size: u16 = 8 + size_of(_id)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&_id)
	return Callback(_id)
}
display_get_registry :: proc(_object: Display) -> Registry {
	_id := generate_id(Registry)
	_object := cast(u32)_object
	_opcode: u16 = 1
	_size: u16 = 8 + size_of(_id)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&_id)
	return Registry(_id)
}
registry_bind :: proc(_object: Registry, name: u32, _name: string, _version: u32, $T: typeid) -> T {
	name := name
	_name := _name
	_version := _version
	_id := generate_id(T)
	_object := cast(u32)_object
	_opcode: u16 = 0
	_size: u16 = 8 + size_of(name) + u16(runtime.align_forward(size_of(u32) + len(_name) + 1, 4)) + size_of(_version) + size_of(_id)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&name)
	write(&_name)
	write(&_version)
	write(&_id)
	return T(_id)
}
compositor_create_surface :: proc(_object: Compositor) -> Surface {
	_id := generate_id(Surface)
	_object := cast(u32)_object
	_opcode: u16 = 0
	_size: u16 = 8 + size_of(_id)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&_id)
	return Surface(_id)
}
compositor_create_region :: proc(_object: Compositor) -> Region {
	_id := generate_id(Region)
	_object := cast(u32)_object
	_opcode: u16 = 1
	_size: u16 = 8 + size_of(_id)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&_id)
	return Region(_id)
}
compositor_release :: proc(_object: Compositor) {
	_object := cast(u32)_object
	_opcode: u16 = 2
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
shm_pool_create_buffer :: proc(_object: Shm_Pool, offset: i32, width: i32, height: i32, stride: i32, format: Shm_Format) -> Buffer {
	_id := generate_id(Buffer)
	offset := offset
	width := width
	height := height
	stride := stride
	format := cast(u32)format
	_object := cast(u32)_object
	_opcode: u16 = 0
	_size: u16 = 8 + size_of(_id) + size_of(offset) + size_of(width) + size_of(height) + size_of(stride) + size_of(format)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&_id)
	write(&offset)
	write(&width)
	write(&height)
	write(&stride)
	write(&format)
	return Buffer(_id)
}
shm_pool_destroy :: proc(_object: Shm_Pool) {
	_object := cast(u32)_object
	_opcode: u16 = 1
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
shm_pool_resize :: proc(_object: Shm_Pool, size: i32) {
	size := size
	_object := cast(u32)_object
	_opcode: u16 = 2
	_size: u16 = 8 + size_of(size)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&size)
}
shm_create_pool :: proc(_object: Shm, fd: Fd, size: i32) -> Shm_Pool {
	_id := generate_id(Shm_Pool)
	fd := fd
	size := size
	_object := cast(u32)_object
	_opcode: u16 = 0
	_size: u16 = 8 + size_of(_id) + size_of(size)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&_id)
	write(&fd)
	write(&size)
	return Shm_Pool(_id)
}
shm_release :: proc(_object: Shm) {
	_object := cast(u32)_object
	_opcode: u16 = 1
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
buffer_destroy :: proc(_object: Buffer) {
	_object := cast(u32)_object
	_opcode: u16 = 0
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
data_offer_accept :: proc(_object: Data_Offer, serial: u32, mime_type: string) {
	serial := serial
	mime_type := mime_type
	_object := cast(u32)_object
	_opcode: u16 = 0
	_size: u16 = 8 + size_of(serial) + u16(runtime.align_forward(size_of(u32) + len(mime_type) + 1, 4))
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&serial)
	write(&mime_type)
}
data_offer_receive :: proc(_object: Data_Offer, mime_type: string, fd: Fd) {
	mime_type := mime_type
	fd := fd
	_object := cast(u32)_object
	_opcode: u16 = 1
	_size: u16 = 8 + u16(runtime.align_forward(size_of(u32) + len(mime_type) + 1, 4))
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&mime_type)
	write(&fd)
}
data_offer_destroy :: proc(_object: Data_Offer) {
	_object := cast(u32)_object
	_opcode: u16 = 2
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
data_offer_finish :: proc(_object: Data_Offer) {
	_object := cast(u32)_object
	_opcode: u16 = 3
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
data_offer_set_actions :: proc(_object: Data_Offer, dnd_actions: Data_Device_Manager_Dnd_Action, preferred_action: Data_Device_Manager_Dnd_Action) {
	dnd_actions := cast(u32)dnd_actions
	preferred_action := cast(u32)preferred_action
	_object := cast(u32)_object
	_opcode: u16 = 4
	_size: u16 = 8 + size_of(dnd_actions) + size_of(preferred_action)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&dnd_actions)
	write(&preferred_action)
}
data_source_offer :: proc(_object: Data_Source, mime_type: string) {
	mime_type := mime_type
	_object := cast(u32)_object
	_opcode: u16 = 0
	_size: u16 = 8 + u16(runtime.align_forward(size_of(u32) + len(mime_type) + 1, 4))
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&mime_type)
}
data_source_destroy :: proc(_object: Data_Source) {
	_object := cast(u32)_object
	_opcode: u16 = 1
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
data_source_set_actions :: proc(_object: Data_Source, dnd_actions: Data_Device_Manager_Dnd_Action) {
	dnd_actions := cast(u32)dnd_actions
	_object := cast(u32)_object
	_opcode: u16 = 2
	_size: u16 = 8 + size_of(dnd_actions)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&dnd_actions)
}
data_device_start_drag :: proc(_object: Data_Device, source: Data_Source, origin: Surface, icon: Surface, serial: u32) {
	source := cast(u32)source
	origin := cast(u32)origin
	icon := cast(u32)icon
	serial := serial
	_object := cast(u32)_object
	_opcode: u16 = 0
	_size: u16 = 8 + size_of(source) + size_of(origin) + size_of(icon) + size_of(serial)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&source)
	write(&origin)
	write(&icon)
	write(&serial)
}
data_device_set_selection :: proc(_object: Data_Device, source: Data_Source, serial: u32) {
	source := cast(u32)source
	serial := serial
	_object := cast(u32)_object
	_opcode: u16 = 1
	_size: u16 = 8 + size_of(source) + size_of(serial)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&source)
	write(&serial)
}
data_device_release :: proc(_object: Data_Device) {
	_object := cast(u32)_object
	_opcode: u16 = 2
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
data_device_manager_create_data_source :: proc(_object: Data_Device_Manager) -> Data_Source {
	_id := generate_id(Data_Source)
	_object := cast(u32)_object
	_opcode: u16 = 0
	_size: u16 = 8 + size_of(_id)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&_id)
	return Data_Source(_id)
}
data_device_manager_get_data_device :: proc(_object: Data_Device_Manager, seat: Seat) -> Data_Device {
	_id := generate_id(Data_Device)
	seat := cast(u32)seat
	_object := cast(u32)_object
	_opcode: u16 = 1
	_size: u16 = 8 + size_of(_id) + size_of(seat)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&_id)
	write(&seat)
	return Data_Device(_id)
}
data_device_manager_release :: proc(_object: Data_Device_Manager) {
	_object := cast(u32)_object
	_opcode: u16 = 2
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
shell_get_shell_surface :: proc(_object: Shell, surface: Surface) -> Shell_Surface {
	_id := generate_id(Shell_Surface)
	surface := cast(u32)surface
	_object := cast(u32)_object
	_opcode: u16 = 0
	_size: u16 = 8 + size_of(_id) + size_of(surface)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&_id)
	write(&surface)
	return Shell_Surface(_id)
}
shell_surface_pong :: proc(_object: Shell_Surface, serial: u32) {
	serial := serial
	_object := cast(u32)_object
	_opcode: u16 = 0
	_size: u16 = 8 + size_of(serial)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&serial)
}
shell_surface_move :: proc(_object: Shell_Surface, seat: Seat, serial: u32) {
	seat := cast(u32)seat
	serial := serial
	_object := cast(u32)_object
	_opcode: u16 = 1
	_size: u16 = 8 + size_of(seat) + size_of(serial)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&seat)
	write(&serial)
}
shell_surface_resize :: proc(_object: Shell_Surface, seat: Seat, serial: u32, edges: Shell_Surface_Resize) {
	seat := cast(u32)seat
	serial := serial
	edges := cast(u32)edges
	_object := cast(u32)_object
	_opcode: u16 = 2
	_size: u16 = 8 + size_of(seat) + size_of(serial) + size_of(edges)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&seat)
	write(&serial)
	write(&edges)
}
shell_surface_set_toplevel :: proc(_object: Shell_Surface) {
	_object := cast(u32)_object
	_opcode: u16 = 3
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
shell_surface_set_transient :: proc(_object: Shell_Surface, parent: Surface, x: i32, y: i32, flags: Shell_Surface_Transient) {
	parent := cast(u32)parent
	x := x
	y := y
	flags := cast(u32)flags
	_object := cast(u32)_object
	_opcode: u16 = 4
	_size: u16 = 8 + size_of(parent) + size_of(x) + size_of(y) + size_of(flags)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&parent)
	write(&x)
	write(&y)
	write(&flags)
}
shell_surface_set_fullscreen :: proc(_object: Shell_Surface, method: Shell_Surface_Fullscreen_Method, framerate: u32, output: Output) {
	method := cast(u32)method
	framerate := framerate
	output := cast(u32)output
	_object := cast(u32)_object
	_opcode: u16 = 5
	_size: u16 = 8 + size_of(method) + size_of(framerate) + size_of(output)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&method)
	write(&framerate)
	write(&output)
}
shell_surface_set_popup :: proc(_object: Shell_Surface, seat: Seat, serial: u32, parent: Surface, x: i32, y: i32, flags: Shell_Surface_Transient) {
	seat := cast(u32)seat
	serial := serial
	parent := cast(u32)parent
	x := x
	y := y
	flags := cast(u32)flags
	_object := cast(u32)_object
	_opcode: u16 = 6
	_size: u16 = 8 + size_of(seat) + size_of(serial) + size_of(parent) + size_of(x) + size_of(y) + size_of(flags)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&seat)
	write(&serial)
	write(&parent)
	write(&x)
	write(&y)
	write(&flags)
}
shell_surface_set_maximized :: proc(_object: Shell_Surface, output: Output) {
	output := cast(u32)output
	_object := cast(u32)_object
	_opcode: u16 = 7
	_size: u16 = 8 + size_of(output)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&output)
}
shell_surface_set_title :: proc(_object: Shell_Surface, title: string) {
	title := title
	_object := cast(u32)_object
	_opcode: u16 = 8
	_size: u16 = 8 + u16(runtime.align_forward(size_of(u32) + len(title) + 1, 4))
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&title)
}
shell_surface_set_class :: proc(_object: Shell_Surface, class_: string) {
	class_ := class_
	_object := cast(u32)_object
	_opcode: u16 = 9
	_size: u16 = 8 + u16(runtime.align_forward(size_of(u32) + len(class_) + 1, 4))
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&class_)
}
surface_destroy :: proc(_object: Surface) {
	_object := cast(u32)_object
	_opcode: u16 = 0
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
surface_attach :: proc(_object: Surface, buffer: Buffer, x: i32, y: i32) {
	buffer := cast(u32)buffer
	x := x
	y := y
	_object := cast(u32)_object
	_opcode: u16 = 1
	_size: u16 = 8 + size_of(buffer) + size_of(x) + size_of(y)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&buffer)
	write(&x)
	write(&y)
}
surface_damage :: proc(_object: Surface, x: i32, y: i32, width: i32, height: i32) {
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
surface_frame :: proc(_object: Surface) -> Callback {
	_id := generate_id(Callback)
	_object := cast(u32)_object
	_opcode: u16 = 3
	_size: u16 = 8 + size_of(_id)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&_id)
	return Callback(_id)
}
surface_set_opaque_region :: proc(_object: Surface, region: Region) {
	region := cast(u32)region
	_object := cast(u32)_object
	_opcode: u16 = 4
	_size: u16 = 8 + size_of(region)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&region)
}
surface_set_input_region :: proc(_object: Surface, region: Region) {
	region := cast(u32)region
	_object := cast(u32)_object
	_opcode: u16 = 5
	_size: u16 = 8 + size_of(region)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&region)
}
surface_commit :: proc(_object: Surface) {
	_object := cast(u32)_object
	_opcode: u16 = 6
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
surface_set_buffer_transform :: proc(_object: Surface, transform: i32) {
	transform := transform
	_object := cast(u32)_object
	_opcode: u16 = 7
	_size: u16 = 8 + size_of(transform)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&transform)
}
surface_set_buffer_scale :: proc(_object: Surface, scale: i32) {
	scale := scale
	_object := cast(u32)_object
	_opcode: u16 = 8
	_size: u16 = 8 + size_of(scale)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&scale)
}
surface_damage_buffer :: proc(_object: Surface, x: i32, y: i32, width: i32, height: i32) {
	x := x
	y := y
	width := width
	height := height
	_object := cast(u32)_object
	_opcode: u16 = 9
	_size: u16 = 8 + size_of(x) + size_of(y) + size_of(width) + size_of(height)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&x)
	write(&y)
	write(&width)
	write(&height)
}
surface_offset :: proc(_object: Surface, x: i32, y: i32) {
	x := x
	y := y
	_object := cast(u32)_object
	_opcode: u16 = 10
	_size: u16 = 8 + size_of(x) + size_of(y)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&x)
	write(&y)
}
surface_get_release :: proc(_object: Surface) -> Callback {
	_id := generate_id(Callback)
	_object := cast(u32)_object
	_opcode: u16 = 11
	_size: u16 = 8 + size_of(_id)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&_id)
	return Callback(_id)
}
seat_get_pointer :: proc(_object: Seat) -> Pointer {
	_id := generate_id(Pointer)
	_object := cast(u32)_object
	_opcode: u16 = 0
	_size: u16 = 8 + size_of(_id)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&_id)
	return Pointer(_id)
}
seat_get_keyboard :: proc(_object: Seat) -> Keyboard {
	_id := generate_id(Keyboard)
	_object := cast(u32)_object
	_opcode: u16 = 1
	_size: u16 = 8 + size_of(_id)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&_id)
	return Keyboard(_id)
}
seat_get_touch :: proc(_object: Seat) -> Touch {
	_id := generate_id(Touch)
	_object := cast(u32)_object
	_opcode: u16 = 2
	_size: u16 = 8 + size_of(_id)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&_id)
	return Touch(_id)
}
seat_release :: proc(_object: Seat) {
	_object := cast(u32)_object
	_opcode: u16 = 3
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
pointer_set_cursor :: proc(_object: Pointer, serial: u32, surface: Surface, hotspot_x: i32, hotspot_y: i32) {
	serial := serial
	surface := cast(u32)surface
	hotspot_x := hotspot_x
	hotspot_y := hotspot_y
	_object := cast(u32)_object
	_opcode: u16 = 0
	_size: u16 = 8 + size_of(serial) + size_of(surface) + size_of(hotspot_x) + size_of(hotspot_y)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&serial)
	write(&surface)
	write(&hotspot_x)
	write(&hotspot_y)
}
pointer_release :: proc(_object: Pointer) {
	_object := cast(u32)_object
	_opcode: u16 = 1
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
keyboard_release :: proc(_object: Keyboard) {
	_object := cast(u32)_object
	_opcode: u16 = 0
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
touch_release :: proc(_object: Touch) {
	_object := cast(u32)_object
	_opcode: u16 = 0
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
output_release :: proc(_object: Output) {
	_object := cast(u32)_object
	_opcode: u16 = 0
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
region_destroy :: proc(_object: Region) {
	_object := cast(u32)_object
	_opcode: u16 = 0
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
region_add :: proc(_object: Region, x: i32, y: i32, width: i32, height: i32) {
	x := x
	y := y
	width := width
	height := height
	_object := cast(u32)_object
	_opcode: u16 = 1
	_size: u16 = 8 + size_of(x) + size_of(y) + size_of(width) + size_of(height)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&x)
	write(&y)
	write(&width)
	write(&height)
}
region_subtract :: proc(_object: Region, x: i32, y: i32, width: i32, height: i32) {
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
subcompositor_destroy :: proc(_object: Subcompositor) {
	_object := cast(u32)_object
	_opcode: u16 = 0
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
subcompositor_get_subsurface :: proc(_object: Subcompositor, surface: Surface, parent: Surface) -> Subsurface {
	_id := generate_id(Subsurface)
	surface := cast(u32)surface
	parent := cast(u32)parent
	_object := cast(u32)_object
	_opcode: u16 = 1
	_size: u16 = 8 + size_of(_id) + size_of(surface) + size_of(parent)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&_id)
	write(&surface)
	write(&parent)
	return Subsurface(_id)
}
subsurface_destroy :: proc(_object: Subsurface) {
	_object := cast(u32)_object
	_opcode: u16 = 0
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
subsurface_set_position :: proc(_object: Subsurface, x: i32, y: i32) {
	x := x
	y := y
	_object := cast(u32)_object
	_opcode: u16 = 1
	_size: u16 = 8 + size_of(x) + size_of(y)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&x)
	write(&y)
}
subsurface_place_above :: proc(_object: Subsurface, sibling: Surface) {
	sibling := cast(u32)sibling
	_object := cast(u32)_object
	_opcode: u16 = 2
	_size: u16 = 8 + size_of(sibling)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&sibling)
}
subsurface_place_below :: proc(_object: Subsurface, sibling: Surface) {
	sibling := cast(u32)sibling
	_object := cast(u32)_object
	_opcode: u16 = 3
	_size: u16 = 8 + size_of(sibling)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&sibling)
}
subsurface_set_sync :: proc(_object: Subsurface) {
	_object := cast(u32)_object
	_opcode: u16 = 4
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
subsurface_set_desync :: proc(_object: Subsurface) {
	_object := cast(u32)_object
	_opcode: u16 = 5
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
fixes_destroy :: proc(_object: Fixes) {
	_object := cast(u32)_object
	_opcode: u16 = 0
	_size: u16 = 8
	write(&_object)
	write(&_opcode)
	write(&_size)
}
fixes_destroy_registry :: proc(_object: Fixes, registry: Registry) {
	registry := cast(u32)registry
	_object := cast(u32)_object
	_opcode: u16 = 1
	_size: u16 = 8 + size_of(registry)
	write(&_object)
	write(&_opcode)
	write(&_size)
	write(&registry)
}

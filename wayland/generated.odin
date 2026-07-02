package wayland

import "xdg"
import "ext"
import "wl"
import "wlr"
Event :: union {
	ext.Foreign_Toplevel_List_V1_Toplevel_Event,
	ext.Foreign_Toplevel_List_V1_Finished_Event,
	ext.Foreign_Toplevel_Handle_V1_Closed_Event,
	ext.Foreign_Toplevel_Handle_V1_Done_Event,
	ext.Foreign_Toplevel_Handle_V1_Title_Event,
	ext.Foreign_Toplevel_Handle_V1_App_Id_Event,
	ext.Foreign_Toplevel_Handle_V1_Identifier_Event,
	ext.Image_Copy_Capture_Session_V1_Buffer_Size_Event,
	ext.Image_Copy_Capture_Session_V1_Shm_Format_Event,
	ext.Image_Copy_Capture_Session_V1_Dmabuf_Device_Event,
	ext.Image_Copy_Capture_Session_V1_Dmabuf_Format_Event,
	ext.Image_Copy_Capture_Session_V1_Done_Event,
	ext.Image_Copy_Capture_Session_V1_Stopped_Event,
	ext.Image_Copy_Capture_Frame_V1_Transform_Event,
	ext.Image_Copy_Capture_Frame_V1_Damage_Event,
	ext.Image_Copy_Capture_Frame_V1_Presentation_Time_Event,
	ext.Image_Copy_Capture_Frame_V1_Ready_Event,
	ext.Image_Copy_Capture_Frame_V1_Failed_Event,
	ext.Image_Copy_Capture_Cursor_Session_V1_Enter_Event,
	ext.Image_Copy_Capture_Cursor_Session_V1_Leave_Event,
	ext.Image_Copy_Capture_Cursor_Session_V1_Position_Event,
	ext.Image_Copy_Capture_Cursor_Session_V1_Hotspot_Event,
	wl.Display_Error_Event,
	wl.Display_Delete_Id_Event,
	wl.Registry_Global_Event,
	wl.Registry_Global_Remove_Event,
	wl.Callback_Done_Event,
	wl.Shm_Format_Event,
	wl.Buffer_Release_Event,
	wl.Data_Offer_Offer_Event,
	wl.Data_Offer_Source_Actions_Event,
	wl.Data_Offer_Action_Event,
	wl.Data_Source_Target_Event,
	wl.Data_Source_Send_Event,
	wl.Data_Source_Cancelled_Event,
	wl.Data_Source_Dnd_Drop_Performed_Event,
	wl.Data_Source_Dnd_Finished_Event,
	wl.Data_Source_Action_Event,
	wl.Data_Device_Data_Offer_Event,
	wl.Data_Device_Enter_Event,
	wl.Data_Device_Leave_Event,
	wl.Data_Device_Motion_Event,
	wl.Data_Device_Drop_Event,
	wl.Data_Device_Selection_Event,
	wl.Shell_Surface_Ping_Event,
	wl.Shell_Surface_Configure_Event,
	wl.Shell_Surface_Popup_Done_Event,
	wl.Surface_Enter_Event,
	wl.Surface_Leave_Event,
	wl.Surface_Preferred_Buffer_Scale_Event,
	wl.Surface_Preferred_Buffer_Transform_Event,
	wl.Seat_Capabilities_Event,
	wl.Seat_Name_Event,
	wl.Pointer_Enter_Event,
	wl.Pointer_Leave_Event,
	wl.Pointer_Motion_Event,
	wl.Pointer_Button_Event,
	wl.Pointer_Axis_Event,
	wl.Pointer_Frame_Event,
	wl.Pointer_Axis_Source_Event,
	wl.Pointer_Axis_Stop_Event,
	wl.Pointer_Axis_Discrete_Event,
	wl.Pointer_Axis_Value120_Event,
	wl.Pointer_Axis_Relative_Direction_Event,
	wl.Keyboard_Keymap_Event,
	wl.Keyboard_Enter_Event,
	wl.Keyboard_Leave_Event,
	wl.Keyboard_Key_Event,
	wl.Keyboard_Modifiers_Event,
	wl.Keyboard_Repeat_Info_Event,
	wl.Touch_Down_Event,
	wl.Touch_Up_Event,
	wl.Touch_Motion_Event,
	wl.Touch_Frame_Event,
	wl.Touch_Cancel_Event,
	wl.Touch_Shape_Event,
	wl.Touch_Orientation_Event,
	wl.Output_Geometry_Event,
	wl.Output_Mode_Event,
	wl.Output_Done_Event,
	wl.Output_Scale_Event,
	wl.Output_Name_Event,
	wl.Output_Description_Event,
	wlr.Foreign_Toplevel_Manager_V1_Toplevel_Event,
	wlr.Foreign_Toplevel_Manager_V1_Finished_Event,
	wlr.Foreign_Toplevel_Handle_V1_Title_Event,
	wlr.Foreign_Toplevel_Handle_V1_App_Id_Event,
	wlr.Foreign_Toplevel_Handle_V1_Output_Enter_Event,
	wlr.Foreign_Toplevel_Handle_V1_Output_Leave_Event,
	wlr.Foreign_Toplevel_Handle_V1_State_Event,
	wlr.Foreign_Toplevel_Handle_V1_Done_Event,
	wlr.Foreign_Toplevel_Handle_V1_Closed_Event,
	wlr.Foreign_Toplevel_Handle_V1_Parent_Event,
	xdg.Output_V1_Logical_Position_Event,
	xdg.Output_V1_Logical_Size_Event,
	xdg.Output_V1_Done_Event,
	xdg.Output_V1_Name_Event,
	xdg.Output_V1_Description_Event,
}

read_event :: proc(object: u32, opcode: u16) -> Event {
	object_type := get_object_type(object)
	switch object_type {
	case ext.Foreign_Toplevel_List_V1:
		switch opcode {
		case 0: return ext.read_foreign_toplevel_list_v1_toplevel(object)
		case 1: return ext.read_foreign_toplevel_list_v1_finished(object)
		}
	case ext.Foreign_Toplevel_Handle_V1:
		switch opcode {
		case 0: return ext.read_foreign_toplevel_handle_v1_closed(object)
		case 1: return ext.read_foreign_toplevel_handle_v1_done(object)
		case 2: return ext.read_foreign_toplevel_handle_v1_title(object)
		case 3: return ext.read_foreign_toplevel_handle_v1_app_id(object)
		case 4: return ext.read_foreign_toplevel_handle_v1_identifier(object)
		}
	case ext.Image_Copy_Capture_Session_V1:
		switch opcode {
		case 0: return ext.read_image_copy_capture_session_v1_buffer_size(object)
		case 1: return ext.read_image_copy_capture_session_v1_shm_format(object)
		case 2: return ext.read_image_copy_capture_session_v1_dmabuf_device(object)
		case 3: return ext.read_image_copy_capture_session_v1_dmabuf_format(object)
		case 4: return ext.read_image_copy_capture_session_v1_done(object)
		case 5: return ext.read_image_copy_capture_session_v1_stopped(object)
		}
	case ext.Image_Copy_Capture_Frame_V1:
		switch opcode {
		case 0: return ext.read_image_copy_capture_frame_v1_transform(object)
		case 1: return ext.read_image_copy_capture_frame_v1_damage(object)
		case 2: return ext.read_image_copy_capture_frame_v1_presentation_time(object)
		case 3: return ext.read_image_copy_capture_frame_v1_ready(object)
		case 4: return ext.read_image_copy_capture_frame_v1_failed(object)
		}
	case ext.Image_Copy_Capture_Cursor_Session_V1:
		switch opcode {
		case 0: return ext.read_image_copy_capture_cursor_session_v1_enter(object)
		case 1: return ext.read_image_copy_capture_cursor_session_v1_leave(object)
		case 2: return ext.read_image_copy_capture_cursor_session_v1_position(object)
		case 3: return ext.read_image_copy_capture_cursor_session_v1_hotspot(object)
		}
	case wl.Display:
		switch opcode {
		case 0: return wl.read_display_error(object)
		case 1: return wl.read_display_delete_id(object)
		}
	case wl.Registry:
		switch opcode {
		case 0: return wl.read_registry_global(object)
		case 1: return wl.read_registry_global_remove(object)
		}
	case wl.Callback:
		switch opcode {
		case 0: return wl.read_callback_done(object)
		}
	case wl.Shm:
		switch opcode {
		case 0: return wl.read_shm_format(object)
		}
	case wl.Buffer:
		switch opcode {
		case 0: return wl.read_buffer_release(object)
		}
	case wl.Data_Offer:
		switch opcode {
		case 0: return wl.read_data_offer_offer(object)
		case 1: return wl.read_data_offer_source_actions(object)
		case 2: return wl.read_data_offer_action(object)
		}
	case wl.Data_Source:
		switch opcode {
		case 0: return wl.read_data_source_target(object)
		case 1: return wl.read_data_source_send(object)
		case 2: return wl.read_data_source_cancelled(object)
		case 3: return wl.read_data_source_dnd_drop_performed(object)
		case 4: return wl.read_data_source_dnd_finished(object)
		case 5: return wl.read_data_source_action(object)
		}
	case wl.Data_Device:
		switch opcode {
		case 0: return wl.read_data_device_data_offer(object)
		case 1: return wl.read_data_device_enter(object)
		case 2: return wl.read_data_device_leave(object)
		case 3: return wl.read_data_device_motion(object)
		case 4: return wl.read_data_device_drop(object)
		case 5: return wl.read_data_device_selection(object)
		}
	case wl.Shell_Surface:
		switch opcode {
		case 0: return wl.read_shell_surface_ping(object)
		case 1: return wl.read_shell_surface_configure(object)
		case 2: return wl.read_shell_surface_popup_done(object)
		}
	case wl.Surface:
		switch opcode {
		case 0: return wl.read_surface_enter(object)
		case 1: return wl.read_surface_leave(object)
		case 2: return wl.read_surface_preferred_buffer_scale(object)
		case 3: return wl.read_surface_preferred_buffer_transform(object)
		}
	case wl.Seat:
		switch opcode {
		case 0: return wl.read_seat_capabilities(object)
		case 1: return wl.read_seat_name(object)
		}
	case wl.Pointer:
		switch opcode {
		case 0: return wl.read_pointer_enter(object)
		case 1: return wl.read_pointer_leave(object)
		case 2: return wl.read_pointer_motion(object)
		case 3: return wl.read_pointer_button(object)
		case 4: return wl.read_pointer_axis(object)
		case 5: return wl.read_pointer_frame(object)
		case 6: return wl.read_pointer_axis_source(object)
		case 7: return wl.read_pointer_axis_stop(object)
		case 8: return wl.read_pointer_axis_discrete(object)
		case 9: return wl.read_pointer_axis_value120(object)
		case 10: return wl.read_pointer_axis_relative_direction(object)
		}
	case wl.Keyboard:
		switch opcode {
		case 0: return wl.read_keyboard_keymap(object)
		case 1: return wl.read_keyboard_enter(object)
		case 2: return wl.read_keyboard_leave(object)
		case 3: return wl.read_keyboard_key(object)
		case 4: return wl.read_keyboard_modifiers(object)
		case 5: return wl.read_keyboard_repeat_info(object)
		}
	case wl.Touch:
		switch opcode {
		case 0: return wl.read_touch_down(object)
		case 1: return wl.read_touch_up(object)
		case 2: return wl.read_touch_motion(object)
		case 3: return wl.read_touch_frame(object)
		case 4: return wl.read_touch_cancel(object)
		case 5: return wl.read_touch_shape(object)
		case 6: return wl.read_touch_orientation(object)
		}
	case wl.Output:
		switch opcode {
		case 0: return wl.read_output_geometry(object)
		case 1: return wl.read_output_mode(object)
		case 2: return wl.read_output_done(object)
		case 3: return wl.read_output_scale(object)
		case 4: return wl.read_output_name(object)
		case 5: return wl.read_output_description(object)
		}
	case wlr.Foreign_Toplevel_Manager_V1:
		switch opcode {
		case 0: return wlr.read_foreign_toplevel_manager_v1_toplevel(object)
		case 1: return wlr.read_foreign_toplevel_manager_v1_finished(object)
		}
	case wlr.Foreign_Toplevel_Handle_V1:
		switch opcode {
		case 0: return wlr.read_foreign_toplevel_handle_v1_title(object)
		case 1: return wlr.read_foreign_toplevel_handle_v1_app_id(object)
		case 2: return wlr.read_foreign_toplevel_handle_v1_output_enter(object)
		case 3: return wlr.read_foreign_toplevel_handle_v1_output_leave(object)
		case 4: return wlr.read_foreign_toplevel_handle_v1_state(object)
		case 5: return wlr.read_foreign_toplevel_handle_v1_done(object)
		case 6: return wlr.read_foreign_toplevel_handle_v1_closed(object)
		case 7: return wlr.read_foreign_toplevel_handle_v1_parent(object)
		}
	case xdg.Output_V1:
		switch opcode {
		case 0: return xdg.read_output_v1_logical_position(object)
		case 1: return xdg.read_output_v1_logical_size(object)
		case 2: return xdg.read_output_v1_done(object)
		case 3: return xdg.read_output_v1_name(object)
		case 4: return xdg.read_output_v1_description(object)
		}
	}
	return nil
}

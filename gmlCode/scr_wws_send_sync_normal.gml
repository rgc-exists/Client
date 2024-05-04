var sync_info = argument0


if(global.wws_networking_is_server){
    
    var extra_vars = variable_struct_get(ds_map_find_value(global.wws_objSync_database, string(sync_info.object_index)), "extra_vars");
    var extra_data = {}
    for(var v = 0; v < array_length(extra_vars); v++){
        var extraV = extra_vars[v];
        if(variable_instance_exists(id, extraV)){
            variable_struct_set(extra_data, extraV, variable_instance_get(id, extraV));
        }
    }
    
    var extra_data_str = json_stringify(extra_data);
    
    var data = scr_wws_create_packet("SyncObject", [
        sync_info.index_in_online_list,
        sync_info.object_index,
        sync_info.x,
        sync_info.y,
        sync_info.image_xscale,
        sync_info.image_yscale,
        sync_info.image_angle,
        sync_info.sprite_index,
        sync_info.image_index,
        sync_info.image_blend,
        sync_info.image_alpha,
        extra_data_str
    ]);
    for (var i = 0; i < ds_list_size(global.wws_networking_ids); i++)
    {
        var send_to = ds_list_find_value(global.wws_networking_ids, i);

        var player = ds_map_find_value(global.wws_players_by_id, send_to);
        scr_wws_send_packet(data, send_to, true, false);
    }
    
    buffer_delete(data)
} else {
    show_debug_message("WARNING: A client tried to sync an object on other clients. This should only happen for hosts!");
}

if(global.wws_networking_is_server){
    
    if(global.wws_level_chunk_index >= global.wws_level_chunk_count){
        global.wws_is_sending_level = false;
        global.wws_in_online_level = true;
        return false;
    }
    
    var data = scr_wws_create_packet("OpenLevelChunk", [global.wws_level_chunks[global.wws_level_chunk_index]]);
    for (var i = 0; i < ds_list_size(global.wws_networking_ids); i++)
    {
        var send_to = ds_list_find_value(global.wws_networking_ids, i);

        var player = ds_map_find_value(global.wws_players_by_id, send_to);
        scr_wws_send_packet(data, send_to, true, false);
        
    }
    buffer_delete(data)
    
    global.wws_level_chunk_index++;
    
} else {
    show_debug_message("WARNING: A client tried to announce a level load! Only the host should be able to do this.")
}
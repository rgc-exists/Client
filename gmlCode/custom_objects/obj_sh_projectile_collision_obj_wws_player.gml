
show_debug_message("A player was hit!")

var data = scr_wws_create_packet("TakeHit", [other.socket_id]);

if(global.wws_networking_is_server){
    for (var i = 0; i < ds_list_size(global.wws_networking_ids); i++)
    {
        var send_to = ds_list_find_value(global.wws_networking_ids, i);
        show_debug_message("Sending to " + string(send_to))

        var player = ds_map_find_value(global.wws_players_by_id, send_to);
        scr_wws_send_packet(data, send_to, true, false);
    }
    buffer_delete(data)
    
} else {
    scr_wws_send_packet(data, global.wws_networking_owner_id, true);
}

instance_destroy();


steam_event_type = ds_map_find_value(async_load, "event_type");
show_debug_message(steam_event_type);

switch (steam_event_type){
    case "lobby_created":
        show_debug_message("Lobby created!")
        global.wws_steam_lobby_id = steam_lobby_get_lobby_id();
    break;
    case "lobby_join_requested":
        steam_lobby_join_id(ds_map_find_value(async_load, "lobby_id"));
    break;
    case "lobby_joined":
        show_debug_message("Lobby joined!");
        scr_wws_join_server(-1, "Test", true);
    break;
}

var packet = buffer_create(6, buffer_grow, 1);
while (steam_net_packet_receive())
{
    steam_net_packet_get_data(packet);
    buffer_seek(packet, buffer_seek_start, 0);
    scr_wws_handle_packet(packet);
}
buffer_delete(packet);

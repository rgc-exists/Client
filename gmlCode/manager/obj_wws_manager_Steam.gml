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

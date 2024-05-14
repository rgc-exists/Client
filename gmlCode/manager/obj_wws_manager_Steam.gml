steam_event_type = ds_map_find_value(async_load, "event_type");

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
        scr_wws_join_server(-1, steam_get_persona_name(), true);
    break;
    case "lobby_chat_update":
        var update_type = ds_map_find_value(async_load, "change_flags");
        var updated_user = ds_map_find_value(async_load, "change_id");
        switch (update_type) { // To show messages in chat
            case 1:
              // Joined
                break;
            case 2:
              // Disconnect
                break;
            case 4:
              // Disconnect without leaving
                break;
            case 8:
              // Kicked
                break;
            case 16:
              // Banned
                break;
        }
        break;
    case "lobby_chat_message":
        var text = steam_lobby_get_chat_message_text(ds_map_find_value(async_load, "message_index"));
        text = string_trim(text)
        if(string_length(text) > obj_wws_manager.maxchatlength)
        {
            show_debug_message("Ignoring too long message")
            return;
        }
        if(string_length(text) == 0)
        {
            show_debug_message("Ignoring empty message")
            return;
        }
        var chatter_id = ds_map_find_value(async_load, "user_id");
        var chatter_name = steam_get_user_persona_name_sync(chatter_id)
        var data = modhelper_create_struct()
        data.content = text
        data.sender = chatter_name
        data.age = 0
        array_push(obj_wws_manager.messages, data)
        break;
    default:
        show_debug_message("Unhandled steam event!: " + steam_event_type);
}

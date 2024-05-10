if(global.wws_networking_is_steam){
    ds_list_clear(global.wws_networking_ids);
    for(var m = 0; m < steam_lobby_get_member_count(); m++){
        ds_list_add(global.wws_networking_ids, steam_lobby_get_member_id(m));
    }
}


// TODO: Move to a menu option maybe?
if (keyboard_check_pressed(vk_ralt))
{
    var steam = show_question("Steam?");
    var name = get_string("Name", "Player");

    if (show_question("Host?"))
    {
        scr_wws_create_server(name, steam);    
    }
    else
    {
        if (steam)
        {
            show_message("You cant join while using steam accept an invite instead!");
            return;
        }

        var ip = get_string("Ip", "127.0.0.1");

        scr_wws_join_server(ip, name, false);
    }
}

if(keyboard_check_pressed(vk_f6) && global.wws_networking_is_steam){
    steam_lobby_activate_invite_overlay()
}

if(global.wws_networking_socket != -1){
    with (obj_player)
    {
        var data = scr_wws_create_packet("PlayerMovement", [room, x, y, lookdir, hp, dead]);
        if(global.wws_networking_is_server){
            for (var i = 0; i < ds_list_size(global.wws_networking_ids); i++)
            {
                var send_to = ds_list_find_value(global.wws_networking_ids, i);
    
                var player = ds_map_find_value(global.wws_players_by_id, send_to);
                scr_wws_send_packet(data, send_to, true, false);
            }
            buffer_delete(data)
            
        } else {
            scr_wws_send_packet(data, global.wws_networking_owner_id, true);
        }
    }
}

if(keyboard_check_pressed(vk_lalt)){
    if(room == level_editor_play_mode){
        if(global.wws_networking_is_server){
            scr_wws_announce_level()
        }
    }
}

if(global.wws_time_sending_level % 5 == 0){
    if(global.wws_is_sending_level){
        scr_wws_send_level_chunk()
    }
}

global.wws_time_sending_level++;





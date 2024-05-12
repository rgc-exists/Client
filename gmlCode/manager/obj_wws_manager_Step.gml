if(global.wws_networking_is_steam){
    ds_list_clear(global.wws_networking_ids);
    for(var m = 0; m < steam_lobby_get_member_count(); m++){
        var pid = steam_lobby_get_member_id(m)
        if(pid == global.wws_networking_socket)
            continue
        show_debug_message("Adding ID: " + string(pid))
        ds_list_add(global.wws_networking_ids, pid);
    }
}


// TODO: Move to a menu option maybe?
if (keyboard_check_pressed(vk_ralt))
{
    var steam = show_question("Steam?");

    if (show_question("Host?"))
    {
        if(steam){
            scr_wws_create_server(steam_get_persona_name(), steam);    
        } else {
            var name = get_string("Name", "Player");
            scr_wws_create_server(name, steam);    
        }
    }
    else
    {
        var name = get_string("Name", "Player");
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
        if(!global.wws_in_online_level){
            global.wws_stats_kills = -1;
            global.wws_stats_deaths = -1;
        }
        var data = scr_wws_create_packet("PlayerMovement", [room, x, y, lookdir, hp, dead, global.wws_stats_kills, global.wws_stats_deaths]);
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


if(global.wws_networking_is_steam){
    var packet = buffer_create(12, buffer_grow, 1);
    while (steam_net_packet_receive())
    {
        var size = steam_net_packet_get_size()
        buffer_resize(packet, size)
        steam_net_packet_get_data(packet);
        buffer_seek(packet, buffer_seek_start, 0);
        show_debug_message("Packet received, size: " + string(buffer_get_size(packet)))
        scr_wws_handle_packet(packet, steam_net_packet_get_sender_id());
    }
    buffer_delete(packet);
}




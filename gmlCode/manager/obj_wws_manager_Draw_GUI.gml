
if(global.wws_in_online_level){
    
    
    ds_map_set(global.wws_stats_others_leaderboard, global.wws_networking_socket, {
        name: steam_get_persona_name(),
        deaths: global.wws_stats_deaths,
        kills: global.wws_stats_kills
    })


    
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    
    var text_size = 0.5;
    
    draw_set_color(c_black);
    draw_set_alpha(0.3);
    draw_rectangle(0, 0, 400, 30, false);
    
    draw_set_alpha(1);
    draw_set_color(c_white)
    scr_draw_text_in_box("USERNAME", 150, 30, text_size, -1, 0, 0, false);
    scr_draw_text_in_box("KILLS", 50, 30, text_size, -1, 200, 0, false);
    scr_draw_text_in_box("DEATHS", 50, 30, text_size, -1, 300, 0, false);
    
    var y_offset = 30;
    
    var keys = ds_map_keys_to_array(global.wws_stats_others_leaderboard);
    
    for (var s = 0; s < ds_map_size(global.wws_stats_others_leaderboard); s++){
        var socket = keys[s];
        var player_stats = ds_map_find_value(global.wws_stats_others_leaderboard, socket);
        
        draw_set_color(c_black);
        draw_set_alpha(0.3);
        draw_rectangle(0, y_offset, 400, y_offset + 30, false);
        
        draw_set_alpha(1);
        draw_set_color(c_white)
        show_debug_message(player_stats.name)
        show_debug_message(player_stats.kills)
        show_debug_message(player_stats.deaths)
        show_debug_message(socket)
        scr_draw_text_in_box(player_stats.name, 150, 30, text_size, -1, 0, y_offset, false);
        scr_draw_text_in_box(string(player_stats.kills), 50, 30, text_size, -1, 200, y_offset, false);
        scr_draw_text_in_box(string(player_stats.deaths), 50, 30, text_size, -1, 300, y_offset, false);
        
        y_offset += 30;
    }
    
    draw_set_color(c_white)
    
}

var reversed_messages = array_reverse(messages)

if(in_chat){
    draw_set_color(c_black)
    draw_set_alpha(0.6)
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false)
    draw_set_color(c_white)
    draw_set_alpha(1)
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_bottom);
    draw_text(5, display_get_gui_height() - 25, ">" + currentMessage)
    
    scale = maxchatlength/(maxchatlength + 34)
    perMsgOffset = 50
    offset = 25 + perMsgOffset
    for(var i = 0; i < array_length(reversed_messages); i++)
    {
        var content = reversed_messages[i].content
        var sender = reversed_messages[i].sender
        draw_text_transformed(5, display_get_gui_height() - offset, sender + ": " + content, scale, scale, 0)
        offset += perMsgOffset*scale
    }
}
else {
    // draw messages with fade
    if(array_length(messages) == 0)
        return
    draw_set_color(c_white)
    draw_set_alpha(1)
    draw_set_halign(fa_left);
    draw_set_valign(fa_bottom);
    scale = maxchatlength/(maxchatlength + 34)
    perMsgOffset = 50
    offset = 25
    var old = reversed_messages[0].age > 15
    if(reversed_messages[0].age >= 10)
        return;
    for(var i = 0; i < (array_length(reversed_messages) < chatDisplayCount ? array_length(reversed_messages) : chatDisplayCount); i++)
    {
        var content = reversed_messages[i].content
        var sender = reversed_messages[i].sender
        draw_set_alpha(clamp(1.25-((i/15)), .2, 1))
        if(old)
        {
            draw_set_alpha(draw_get_alpha()*(1-((reversed_messages[0].age-10)/5)))
        }
        draw_text_transformed(5, display_get_gui_height() - offset, sender + ": " + content, scale, scale, 0)
        offset += perMsgOffset*scale
    }
}

for(var i = 0; i < array_length(messages); i++)
{
    if(messages[i].age <= 15)
    messages[i].age += 1/60
}


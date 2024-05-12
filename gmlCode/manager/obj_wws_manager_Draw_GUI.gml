
if(global.wws_in_online_level){
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
        scr_draw_text_in_box(player_stats.name, 150, 30, text_size, -1, 0, y_offset, false);
        scr_draw_text_in_box(player_stats.kills, 50, 30, text_size, -1, 200, y_offset, false);
        scr_draw_text_in_box(player_stats.deaths, 50, 30, text_size, -1, 300, y_offset, false);
        
        y_offset += 30;
    }
    draw_set_color(c_white)
}


draw_set_color(c_black);
draw_set_alpha(0.3);
draw_rectangle(0, y_offset, 400, y_offset + 30, false);

draw_set_alpha(1);
draw_set_color(c_white)
scr_draw_text_in_box(obj_player.name, 150, 30, text_size, -1, 0, y_offset, false);
scr_draw_text_in_box(global.wws_stats_kills, 50, 30, text_size, -1, 200, y_offset, false);
scr_draw_text_in_box(global.wws_stats_deaths, 50, 30, text_size, -1, 300, y_offset, false);

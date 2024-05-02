var chunk = argument1;


if(global.wws_is_recieving_level){
    show_debug_message("Chunk:\n" + string(chunk) + "\n\n\n\n\n\n");
    global.wws_level_chunks_left--;
    if(global.wws_level_chunks_left <= 0){
        global.wws_is_recieving_level = false;
        
        global.wws_temp_level_path = "WWS_cache_" + scr_createcampaignname(7)
        var file = file_text_open_write(get_campaigns_load_path_prefix() + "Community Levels/" + global.wws_temp_level_path + ".lvl");
        file_text_write_string(file, global.wws_temp_level_string);
        file_text_close(file);
        
        global.wws_in_online_level = true;
        scr_wws_play_sent_level(false)
        return false;
    }
    global.wws_temp_level_string += chunk;
} else {
    show_debug_message("WARNING: The client was told to load a level chunk, but wws_is_recieving_level is false!");
    return false;
}

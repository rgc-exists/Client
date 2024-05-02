
if(global.wws_networking_is_server){
    var current_campaign = ds_map_find_value(global.campaignMap, global.currentCampaign);
    var current_level_info = current_campaign.levels[global.campaignLevelIndex];
    
    var current_level_path = leveleditor_get_filepath(global.currentCampaign, current_level_info.fileName);
    
    show_debug_message("Sending level from " + current_level_path + " to clients.")
    var current_level = file_text_open_read(current_level_path);
    
    global.wws_level_to_send = "";
    while(!file_text_eof(current_level)){
        global.wws_level_to_send += file_text_read_string(current_level) + "\n"
        file_text_readln(current_level)
    }
    file_text_close(current_level)
    
    
    var chunk_count = ceil(string_length(global.wws_level_to_send) / global.wws_char_per_level_chunk) + 1
    var data = scr_wws_create_packet("OpenLevelAnnouncement", [chunk_count]);
    for (var i = 0; i < ds_list_size(global.wws_networking_ids); i++)
    {
        var send_to = ds_list_find_value(global.wws_networking_ids, i);

        var player = ds_map_find_value(global.wws_players_by_id, send_to);
        scr_wws_send_packet(data, send_to, true, false);
    }
    buffer_delete(data)
    
    global.wws_level_chunks = [];
    for(var i = 0; i < chunk_count; i++){
        var start_char = i * global.wws_char_per_level_chunk + 1;
        
        if(i == chunk_count - 1){
            var new_chunk = string_copy(global.wws_level_to_send, start_char, string_length(global.wws_char_per_level_chunk) + 1 - start_char);
        } else {
            var new_chunk = string_copy(global.wws_level_to_send, start_char, global.wws_char_per_level_chunk);
        }
        array_push(global.wws_level_chunks, new_chunk)
    }
    
    global.wws_is_sending_level = true;
    global.wws_level_chunk_count = chunk_count;
    global.wws_level_chunk_index = 0;
    global.wws_time_sending_level = 0;
} else {
    show_debug_message("WARNING: A client tried to announce a level load! Only the host should be able to do this.")
}
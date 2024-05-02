show_debug_message(saveName);
if(global.wws_in_online_level){
    saveName = get_campaigns_load_path_prefix() + "Community Levels/" + global.wws_temp_level_path + ".lvl";
}
show_debug_message(saveName);
return #orig#();
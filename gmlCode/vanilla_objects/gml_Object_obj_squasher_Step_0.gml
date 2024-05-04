if(global.wws_in_online_level && global.wws_networking_is_client){
    if (!(scr_place_free_walkthrough(x, y)))
        event_user(0)
    return false; 
}
#orig#()
var socket = argument1;
show_debug_message(string(global.wws_networking_socket));
if(socket == global.wws_networking_socket){
    obj_player.hp -= 1;
} else {
    var player = ds_map_find_value(global.wws_players_by_id, socket);
    if(instance_exists(player)){
        player.hp -= 1;
    }
}
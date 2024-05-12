var socket = argument1;
show_debug_message(string(global.wws_networking_socket));
if(socket == global.wws_networking_socket){
    obj_player.hp -= 1;
    
    with(obj_player){
        if(hp < 0){
        	show_debug_message("Player was killed!")
            var data = scr_wws_create_packet("PlayerKilled", []);
        	scr_player_death(other.image_angle, obj_sh_projectile)
	    	scr_wws_send_packet(data, argument0, true);
	    }
    }
} else {
    var player = ds_map_find_value(global.wws_players_by_id, socket);
    if(instance_exists(player)){
        player.hp -= 1;
    }
}

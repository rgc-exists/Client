var socket = argument1;

if(global.wws_in_online_level){
	if(socket == global.wws_networking_socket){
		if(obj_player.dead < 0){
		    obj_player.hp -= 1;
		    
		    with(obj_player){
		        if(hp < 0){
		        	show_debug_message("Player was killed!")
		            var data = scr_wws_create_packet("PlayerKilled", []);
		        	scr_player_death(other.image_angle, obj_sh_projectile)
			    	scr_wws_send_packet(data, argument0, true);
			    }
		    }
		}
	} else {
	    var player = ds_map_find_value(global.wws_players_by_id, socket);
	    if(instance_exists(player)){
	        player.hp -= 1;
	    }
	}
	if(room != level_editor_play_mode){
		array_push(global.wws_hits_built_up, argument0);
	}
}
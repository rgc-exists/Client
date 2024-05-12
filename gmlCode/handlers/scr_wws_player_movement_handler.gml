var socket_id = argument0;
var room_id = argument1;
var xpos = argument2;
var ypos = argument3;
var lookdir = argument4;
var hp = argument5;
var dead = argument6;
var kills = argument7;
var deaths = argument8;


var player = ds_map_find_value(global.wws_players_by_id, socket_id);
if(!instance_exists(player)){
    show_debug_message("Player doesn't exist: " + string(socket_id))
    return false
};
player.room_id = room_id
player.x = xpos;
player.y = ypos;
player.lookdir = lookdir
player.hp = hp;
player.dead = dead;

var player_info = ds_map_find_value(global.wws_stats_others_leaderboard, socket_id);
if(is_undefined(player_info) || player_info == -1){
    show_debug_message("Player wasn't in the leaderboard info map: " + string(socket_id));
}

player_info.kills = kills;
player_info.deaths = deaths;
ds_map_set(global.wws_stats_others_leaderboard, socket_id, player_info);
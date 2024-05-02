var socket_id = argument0;
var room_id = argument1;
var xpos = argument2;
var ypos = argument3;
var lookdir = argument4;


var player = ds_map_find_value(global.wws_players_by_id, socket_id);
if(!instance_exists(player)) return false;
player.room_id = room_id
player.x = xpos;
player.y = ypos;
player.lookdir = lookdir
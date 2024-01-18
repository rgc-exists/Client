var socket_id = argument1;
var hat = argument2;
var room_id = argument3;
var name = argument4;

var player = instance_create_layer(-240, -240, "Player", obj_wws_player);
player.room_id = room_id;
player.name = name;
ds_map_add(global.wws_players_by_id, socket_id, player);
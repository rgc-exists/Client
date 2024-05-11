var socket_id = argument0;
var room_id = argument1;
var xpos = argument2;
var ypos = argument3;
var lookdir = argument4;
var hp = argument5;
var dead = argument6;


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
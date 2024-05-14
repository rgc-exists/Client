var socket_id = argument0;
var hat = argument1;
var room_id = argument2;
var name = argument3;

var player = instance_create_layer(240, 240, "Player", obj_wws_player);
player.room_id = room_id;
player.name = name;
if(global.wws_networking_is_steam) {
    player.name = steam_get_user_persona_name_sync(socket_id)
}
player.socket_id = socket_id;
ds_map_add(global.wws_players_by_id, socket_id, player);
ds_map_add(global.wws_stats_others_leaderboard, socket_id, {
    name: player.name,
    deaths: 0,
    kills: 0
})


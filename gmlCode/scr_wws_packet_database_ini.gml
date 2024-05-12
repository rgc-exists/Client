/*
{
    pid     // uint16 with the id of the packet
    name    // internal name for the packet 
    types   // array of buffer types for the data of the packet
    handler // function to be called with the read data when this packet is recived
}
*/

global.wws_packet_database = ds_map_create();
global.wws_packets_by_id = ds_map_create();

global.wws_bullets_by_id = ds_map_create();

global.wws_networking_ids = ds_list_create()

global.wws_char_per_level_chunk = 1000;

global.wws_time_sending_level = 0;
global.wws_is_sending_level = false;
global.wws_is_recieving_level = false;

global.wws_in_online_level = false;

global.wws_level_chunks_left = 0;
global.wws_level_chunk_index = 0;

global.wws_max_player_health = 40;

global.wws_steam_lobby_id = undefined;

global.wws_networking_is_server = false;
global.wws_networking_is_steam = false;
global.wws_networking_socket = -1;

global.wws_networking_owner_id = 0;

global.wws_stats_kills = 0;
global.wws_stats_deaths = 0;

global.wws_stats_others_leaderboard = ds_map_create();

            
/*
{
    hat
    roomid
    name
}
*/
var packet = modhelper_create_struct();
packet.pid = 0;
packet.name = "PlayerJoin";
packet.types = [buffer_s8, buffer_u16, buffer_string];
packet.handler = asset_get_index("scr_wws_player_join_handler");
ds_map_add(global.wws_packet_database, packet.name, packet);

/*
{
    socket_id
    hat
    roomid
    name
}
*/
packet = modhelper_create_struct();
packet.pid = 1;
packet.name = "PlayerJoinS2C";
packet.types = [buffer_u16, buffer_s8, buffer_u16, buffer_string];
packet.handler = asset_get_index("scr_wws_player_join_handler_client");
ds_map_add(global.wws_packet_database, packet.name, packet);

/*
{
    room
    x
    y
    lookdir
    hp
    dead
    kills
    deaths
}
*/
packet = modhelper_create_struct();
packet.pid = 2;
packet.name = "PlayerMovement";
packet.types = [buffer_u16, buffer_f32, buffer_f32, buffer_s8, buffer_s16, buffer_s16, buffer_u32, buffer_u32];
packet.handler = asset_get_index("scr_wws_player_movement_handler");
ds_map_add(global.wws_packet_database, packet.name, packet);


//PLAYERMOVEMENTS2C IS UNUSED
/*
{
    socket_id
    room
    x
    y
    lookdir
}
*/
packet = modhelper_create_struct();
packet.pid = 3;
packet.name = "PlayerMovementS2C";
packet.types = [buffer_u16, buffer_u16, buffer_f32, buffer_f32, buffer_s8];
packet.handler = asset_get_index("scr_wws_player_join_handler_client");
ds_map_add(global.wws_packet_database, packet.name, packet);
//PLAYERMOVEMENTS2C IS UNUSED

packet = {
    pid: 4,
    name: "OpenLevelAnnouncement",
    types: [
        buffer_u16 //Number of chunks
    ],
    handler: asset_get_index("scr_wws_level_load_handler")
}
ds_map_add(global.wws_packet_database, packet.name, packet);

packet = {
    pid: 5,
    name: "OpenLevelChunk",
    types: [
        buffer_string //Section of level string
    ],
    handler: asset_get_index("scr_wws_level_chunk_handler")
}
ds_map_add(global.wws_packet_database, packet.name, packet);

//THE SYNC OBJECT SYSTEM IS CURRENTLY NOT IN USE. INDIVIDUAL OBJECTS HAVE THEIR OWN PACKETS.
packet = {
    pid: 6,
    name: "SyncObject",
    types: [
        buffer_u16, //Index of the object in the obj list
        buffer_u8, //Object ID
        buffer_f64, //XPos
        buffer_f64, //YPos
        buffer_f64, //XScale
        buffer_f64, //YScale
        buffer_f64, //Rotation
        buffer_string //Extra data
    ],
    handler: asset_get_index("scr_wws_objSync_handler")
}
ds_map_add(global.wws_packet_database, packet.name, packet);

packet = {
    pid: 7,
    name: "DoorState",
    types: [
        buffer_u16, //Index of the object in the doors list
        buffer_u16, //Open
        buffer_u16, //image_yscale
    ],
    handler: asset_get_index("scr_wws_door_state_handler")
}
ds_map_add(global.wws_packet_database, packet.name, packet);

packet = {
    pid: 8,
    name: "TakeHit",
    types: [
        buffer_u64 //Socket ID that took damage
    ],
    handler: asset_get_index("scr_wws_take_hit_handler")
}
ds_map_add(global.wws_packet_database, packet.name, packet);

packet = {
    pid: 9,
    name: "ShootBullet",
    types: [
        buffer_string, //Bullet_ID
        buffer_f64, //XPos
        buffer_f64, //YPos
        buffer_f64, //Rotation
    ],
    handler: asset_get_index("scr_wws_shoot_bullet_handler")
}
ds_map_add(global.wws_packet_database, packet.name, packet);

packet = {
    pid: 10,
    name: "DestroyBullet",
    types: [
        buffer_string //Bullet_ID
    ],
    handler: asset_get_index("scr_wws_destroy_bullet_handler")
}
ds_map_add(global.wws_packet_database, packet.name, packet);

packet = {
    pid: 11,
    name: "PlayerKilled",
    types: [
    ],
    handler: asset_get_index("scr_wws_kill_handler")
}
ds_map_add(global.wws_packet_database, packet.name, packet);

// TODO: Add a hookable function for modders

var key = ds_map_find_first(global.wws_packet_database);
packet = ds_map_find_value(global.wws_packet_database, key);
ds_map_add(global.wws_packets_by_id, packet.pid, packet);

for (var i = 0; i < ds_map_size(global.wws_packet_database) - 1; i++)
{
    key = ds_map_find_next(global.wws_packet_database, key);
    packet = ds_map_find_value(global.wws_packet_database, key);
    ds_map_add(global.wws_packets_by_id, packet.pid, packet);
}
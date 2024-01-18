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

var packet = modhelper_create_struct();
packet.pid = 0;
packet.name = "PlayerJoin";
packet.types = [buffer_s8, buffer_u16, buffer_string];
packet.handler = asset_get_index("scr_wws_player_join_handler");
ds_map_add(global.wws_packet_database, packet.name, packet);

packet = modhelper_create_struct();
packet.pid = 1;
packet.name = "PlayerJoinS2C";
packet.types = [buffer_u16, buffer_s8, buffer_u16, buffer_string];
packet.handler = asset_get_index("scr_wws_player_join_handler_client");
ds_map_add(global.wws_packet_database, packet.name, packet);

packet = modhelper_create_struct();
packet.pid = 2;
packet.name = "PlayerMovement";
packet.types = [buffer_u16, buffer_f32, buffer_f32, buffer_bool];
packet.handler = asset_get_index("scr_wws_player_movement_handler");
ds_map_add(global.wws_packet_database, packet.name, packet);

packet = modhelper_create_struct();
packet.pid = 3;
packet.name = "PlayerMovementS2C";
packet.types = [buffer_u16, buffer_u16, buffer_f32, buffer_f32, buffer_bool];
packet.handler = asset_get_index("scr_wws_player_join_handler_client");
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
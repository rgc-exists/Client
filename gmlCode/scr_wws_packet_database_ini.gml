/*
{
    id      // uint16 with the id of the packet
    name    // internal name for the packet 
    types   // array of buffer types for the data of the packet
    handler // function to be called with the read data when this packet is recived
    builder // function to be called to build a new packet of this type (may get removed in favor of an automatic build system)
}
*/

global.wws_packet_database = ds_map_create();

var packet = modhelper_create_struct();
variable_struct_set(packet, "id", 0);
variable_struct_set(packet, "name", "Player Join");
variable_struct_set(packet, "types", [buffer_u8, buffer_string]);
variable_struct_set(packet, "handler", scr_wws_player_join_handler);
variable_struct_set(packet, "builder", scr_wws_player_join_builder);
ds_map_add(global.wws_packet_database, variable_struct_get(packet, "id"), packet);
global.wws_packet_database = ds_map_create();

var packet = modhelper_create_struct();
struct_set(packet, "id", 0);
struct_set(packet, "name", "Player Join");
var types = ds_list_create();
ds_list_add(types, buffer_u8, buffer_string);
struct_set(packet, "types", types);
struct_set(packet, "handler", scr_wws_player_join_handler);
struct_set(packet, "builder", scr_wws_player_join_builder);
ds_map_add(struct_get(packet, "id"), packet);
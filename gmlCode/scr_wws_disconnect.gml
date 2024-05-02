global.wws_networking_is_client = false;
global.wws_networking_is_server = false;

if (global.wws_networking_is_steam)
{

} else {
   network_destroy(global.wws_networking_socket);
}

ds_list_destroy(global.wws_networking_ids);
ds_map_destroy(global.wws_players_by_id); 
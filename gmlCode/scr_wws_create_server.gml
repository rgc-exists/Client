var name = argument0;  // Player name of the host
var steam = argument1; // Is server being created with steam

global.wws_networking_is_steam = steam;
global.wws_networking_is_client = false;
global.wws_networking_is_server = true;
global.wws_networking_ids = ds_list_create();
global.wws_players_by_id = ds_map_create();

if (steam)
{
    
}
else
{
    global.wws_networking_socket = network_create_server_raw(network_socket_tcp, 25565, 32);
}
var destination = argument0; // Ip or steam id to join
var name = argument1;        // Player name
var steam = argument2;       // Is the server thats being joined run on steam

// Note: does steam networking even need this?

global.wws_networking_is_steam = steam;
global.wws_networking_is_client = true;
global.wws_networking_is_server = false;
global.wws_networking_ids = ds_list_create();
global.wws_players_by_id = ds_map_create();

if (steam)
{
    global.wws_networking_socket = steam_get_user_steam_id();
    global.wws_networking_owner_id = steam_lobby_get_owner_id();
    //global.wws_networking_socket = steam_get_user_account_id()
    var data = scr_wws_create_packet("PlayerJoin", [global.save_equipped_hat, room, name]);
    scr_wws_send_packet(data, global.wws_networking_owner_id, true);
}
else
{
    global.wws_networking_socket = network_create_socket(network_socket_tcp);
    global.wws_networking_owner_id = 0;
    network_connect_raw(global.wws_networking_socket, destination, 25565);
    var data = scr_wws_create_packet("PlayerJoin", [global.save_equipped_hat, room, name]);
    scr_wws_send_packet(data, global.wws_networking_owner_id, true);
}

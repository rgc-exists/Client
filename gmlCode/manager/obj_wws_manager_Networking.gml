var type = ds_map_find_value(async_load, "type");
var socket = ds_map_find_value(async_load, "socket");

switch (type)
{
    case network_type_connect:
        ds_list_add(global.wws_networking_ids, socket);

        var player = instance_create_layer(-240, -240, "Player", obj_wws_player);
        ds_map_add(global.wws_players_by_id, socket, player);
        break;

    case network_type_disconnect:
        ds_list_delete(global.wws_networking_ids, ds_list_find_index(global.wws_networking_ids, socket));

        var player = ds_map_find_value(global.wws_players_by_id, socket);
        instance_destroy(player);
        break;

    case network_type_data:
        var data = ds_map_find_value(async_load, "buffer");
        var socket_id = ds_map_find_value(async_load, "id");

        scr_wws_handle_packet(data, socket_id);
        break;
}
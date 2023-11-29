var type = ds_map_find_value(async_load, "type");
var socket = ds_map_find_value(async_load, "socket");

switch (type)
{
    case network_type_connect:
        ds_list_add(global.wws_networking_ids, socket);
        break;

    case network_type_disconnect:
        ds_list_delete(global.wws_networking_ids, ds_list_find_index(global.wws_networking_ids, socket));
        break;

    case network_type_data:
        var data = ds_map_find_value(async_load, "buffer");

        scr_wws_handle_packet(data);
        break;
}
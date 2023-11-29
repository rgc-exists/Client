var type = ds_map_find_value(async_load, "type");
var socket = ds_map_find_value(async_load, "socket");

switch (type)
{
    case network_type_connect:
        break;

    case network_type_disconnect:
        break;

    case network_type_data:
        var data = ds_map_find_value(async_load, "buffer");

        scr_wws_handle_packet(data);
        break;
}
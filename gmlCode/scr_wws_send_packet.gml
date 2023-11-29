var data = argument0;     // Buffer containing the packet data
var sid = argument1;      // Either socket or steam id to send the data to
var reliable = argument2; // Is the packet reliable

if (global.wws_networking_is_steam)
{

}
else
{
    network_send_packet(global.wws_networking_socket, data, buffer_get_size(data));
    buffer_delete(data);
}
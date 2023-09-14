var data = argument0;     // Buffer containing the packet data
var id = argument1;       // Either socket or steam id to send the data to
var reliable = argument2; // Is the packet reliable
var packet = argument3;   // Packet struct

scr_wws_create_final_packet(data, packet);

if (global.wws_networking_is_steam)
{

}
else
{

}
var name = argument0; // Name of packet
var data = argument1; // Array of data to write

var packetdata = buffer_create(6, buffer_grow, 1);
var packet = ds_map_find_value(global.wws_packet_database, name);
show_debug_message("Making packet:")
show_debug_message("Defined: " + string(!is_undefined(packet)))
show_debug_message("Packet PID: " + string(packet.pid))
show_debug_message("1")
buffer_write(packetdata, buffer_u16, packet.pid);
show_debug_message("2")
buffer_write(packetdata, buffer_u32, 0);
show_debug_message("3")
for (var i = 0; i < array_length(packet.types); i++) 
{ 
    show_debug_message("LOOP: " + string(i))
    buffer_write(packetdata, packet.types[i], data[i]);
}
show_debug_message("4")
buffer_seek(packetdata, buffer_seek_start, 2);
show_debug_message("5")
buffer_write(packetdata, buffer_u32, buffer_crc32(packetdata, 6, buffer_get_size(packetdata) - 6)); // Might need to offset this?

show_debug_message("Created packet of name " + name);

return packetdata;
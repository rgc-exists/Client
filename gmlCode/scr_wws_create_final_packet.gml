var data = argument0;
var packet = argument1;

buffer_seek(data, buffer_seek_start, 0);
buffer_write(data, buffer_u16, struct_get(packet, "id"));
buffer_seek(data, buffer_seek_start, 0);
buffer_write(buffer_s32, buffer_crc32(data, 0, buffer_get_size(data)));
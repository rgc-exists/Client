

if(global.wws_networking_is_server){
    if(global.wws_in_online_level){
        if(room == level_editor_play_mode){
            var key = ds_map_find_first(global.wws_objSync_database);
            for(var k = 0; k < ds_map_size(global.wws_objSync_database); k++){
                var sync_obj_index = real(key);
                var sync_info = ds_map_find_value(global.wws_objSync_database, key);
                var i = 0;
                for(var o = 0; o < instance_number(sync_obj_index); o++){
                    with(instance_find(sync_obj_index, o)){
                        var sync_info = {
                            index_in_online_list: i,
                            object_index: object_index,
                            x: x,
                            y: y,
                            image_xscale: image_xscale,
                            image_yscale: image_yscale,
                            image_angle: image_angle,
                            sprite_index: sprite_index,
                            image_index: image_index,
                            image_blend: image_blend,
                            image_alpha: image_alpha,
                        }
                        scr_wws_send_sync_normal(sync_info)
                    }
                    i++;
                }
                key = ds_map_find_next(global.wws_objSync_database, key);
            }
        }
    }
}

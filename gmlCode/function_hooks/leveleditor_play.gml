if(global.wws_in_online_level){
    if(global.wws_networking_is_client){
        saveName = get_campaigns_load_path_prefix() + "Community Levels/" + global.wws_temp_level_path + ".lvl";
    }
}

if(!is_undefined(global.wws_objects_in_level)){
    if(ds_exists(global.wws_objects_in_level, ds_type_list))
        ds_list_destroy(global.wws_objects_in_level);
}

global.wws_objects_in_level = ds_list_create();

var key = ds_map_find_first(global.wws_objSync_database);
for(var k = 0; k < ds_map_size(global.wws_objSync_database); k++){
    show_debug_message("Adding an object of index " + key + " to the list.");
    var sync_obj_index = real(key);
    var sync_data = ds_map_find_value(global.wws_objSync_database, key);
    var i = 0;
    for(var o = 0; o < instance_number(sync_obj_index); o++){
        var found_instance = instance_find(sync_obj_index, o)
        ds_list_add(global.wws_objects_in_level, found_instance);
        with(found_instance){
            show_debug_message("INSTANCE WITH IS WORKING WTF")
            index_in_online_list = i;
            i++;
        }
    }
    key = ds_map_find_next(global.wws_objSync_database, key);
}

return #orig#();
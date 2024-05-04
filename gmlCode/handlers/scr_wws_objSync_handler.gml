var index_in_online_list = argument1;
var sync_object_index = argument2;
var sync_x = argument3;
var sync_y = argument4;
var sync_image_xscale = argument5;
var sync_image_yscale = argument6;
var sync_image_angle = argument7;
var sync_sprite_index = argument8;
var sync_image_index = argument9;
var sync_image_blend = argument10
var sync_image_alpha = argument11
var extra_data_str = argument12;

//show_debug_message("X: " + string(sync_x))
//show_debug_message("Y: " + string(sync_y))

if(global.wws_networking_is_client){
    with(ds_list_find_value(global.wws_objects_in_level, index_in_online_list)){
        x = sync_x;
        y = sync_y;
        image_xscale = sync_image_xscale;
        image_yscale = sync_image_yscale;
        image_angle = sync_image_angle;
        sprite_index = sync_sprite_index;
        image_index = sync_image_index;
        image_blend = sync_image_blend;
        image_alpha = sync_image_alpha;
        
        show_debug_message("SYNCING OBJECT!!!!!!!!!!!")

        
        
        var extra_data = json_parse(extra_data_str);
        var var_names = variable_struct_get_names(extra_data);
        for(var v = 0; v < array_length(var_names); v++){
            var cur_name = var_names[v];
            var cur_value = variable_struct_get(extra_data, cur_name)
            variable_instance_set(id, cur_name, cur_value);
        }
    }
} else {
    show_debug_message("WARNING: The host was told to change an object based on sync. Only the clients should do this!");
    return false;
}

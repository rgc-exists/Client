/*
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
THE SYNC OBJECT SYSTEM IS CURRENTLY NOT IN USE. INDIVIDUAL OBJECTS HAVE THEIR OWN PACKETS.
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
*/


global.wws_objSync_database = ds_map_create();
global.wws_objects_in_level = undefined;

var sync_info = {
    obj_index: asset_get_index("obj_squasher"),
    extra_vars: ["hspeed", "vspeed", "aw_x_last", "aw_y_last", "aw_delta_hspeed", "aw_delta_vspeed", "aw_hspeed_last", "aw_vspeed_last", "aw_target_xscale_speed", "aw_target_xscale", "aw_target_yscale_speed", "aw_target_yscale", "aw_OUT_xscale", "aw_OUT_yscale", "aw_target_angle_speed", "aw_target_angle", "aw_OUT_angle"]
}
ds_map_add(global.wws_objSync_database, string(asset_get_index("obj_squasher")), sync_info);

var sync_info = {
    obj_index: asset_get_index("obj_disco_laser"),
    extra_vars: ["enabled", "enablenr", "justenabled"]
}
ds_map_add(global.wws_objSync_database, string(asset_get_index("obj_disco_laser")), sync_info);

var sync_info = {
    obj_index: asset_get_index("obj_smiley_collectable_coin"),
    extra_vars: []
}
ds_map_add(global.wws_objSync_database, string(asset_get_index("obj_smiley_collectable_coin")), sync_info);


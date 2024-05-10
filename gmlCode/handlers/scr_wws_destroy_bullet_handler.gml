var bullet_id = argument1;

var bullet = ds_map_find_value(global.wws_bullets_by_id, bullet_id)
if (bullet != -1){
    instance_destroy(bullet);
    ds_map_delete(global.wws_bullets_by_id, bullet_id);
}
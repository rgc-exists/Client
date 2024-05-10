var door_index = argument1;
var open = argument2;
var sync_yscale = argument3;

show_debug_message(image_yscale);

with(instance_find(obj_door_leveleditor, door_index)){
    online_open = open;
    if(open)
        image_yscale = sync_yscale;
    else 
        image_yscale = yscale;
    just_recieved_sync = true;
}
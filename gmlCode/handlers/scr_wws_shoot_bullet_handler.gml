var bullet_id = argument1;
var xpos = argument2;
var ypos = argument3;
var rot = argument4;

idmerk = instance_create_layer(xpos, ypos, "Player", obj_wws_projectile);
idmerk.bullet_id = bullet_id;
idmerk.direction = rot;
idmerk.image_angle = idmerk.direction;
idmerk.speed = 20;
idmerk.image_xscale = 0.2;
idmerk.image_yscale = 0.2;
ds_map_add(global.wws_bullets_by_id, bullet_id, idmerk)
x = mouse_x ;
y = mouse_y;
image_xscale = 2;
image_yscale = 2;
if(mouse_check_button(mb_left))
    image_speed = 1;
else {
    image_index = 0;
    image_speed = 0;
}
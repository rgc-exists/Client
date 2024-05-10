if(dead < 0){
    draw_set_color(c_white)
    
    draw_set_halign(fa_center)
    draw_set_valign(fa_bottom)
    
    draw_text_transformed(x, y - 60, name, 0.5, 0.5, 0)
    
    house_height = lerp(house_height, (1 + (vspeed * 0.05)), 0.2)
    house_height = clamp(house_height, 0.4, 1.6)
    house_width = clamp((1 / house_height), 0.8, 5)
    house_tilt = lerp(house_tilt, hspeed, 0.1)
    house_sprite = spr_snail_house
    if (gun_equipped == 1)
        house_sprite = spr_snail_house_gun
    if (gun_equipped == 2)
        house_sprite = spr_snail_house_gun2
    if (gun_equipped == 3)
        house_sprite = spr_snail_house_gun3
    if (gun_equipped == 4)
        house_sprite = spr_snail_house_gun4
    if (gun_equipped == 6)
        house_sprite = spr_snail_house_gun4
    draw_sprite_ext(house_sprite, 0, (x - (15 * lookdir)), (y + 16), (house_width * lookdir), house_height, house_tilt, col_snail_shell, 1)
    draw_sprite_ext(house_sprite, 1, (x - (15 * lookdir)), (y + 16), (house_width * lookdir), house_height, house_tilt, col_snail_outline, 1)
    draw_sprite_ext(spr_player_base, 0, x, y, (image_xscale * lookdir), image_yscale, image_angle, col_snail_body, 1)
    draw_sprite_ext(spr_player_base, 1, x, y, (image_xscale * lookdir), image_yscale, image_angle, col_snail_outline, 1)
    
    draw_healthbar(x - 30, y - 50, x + 30, y - 40, hp / global.wws_max_player_health * 100, c_red, c_aqua, c_aqua, 0, true, true);
} else {
    
}
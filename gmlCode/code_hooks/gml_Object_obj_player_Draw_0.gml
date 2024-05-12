if (gun_equipped == 6)
    house_sprite = spr_snail_house_gun4;
    
#orig#()

draw_healthbar(x - 30, y - 50, x + 30, y - 40, hp / global.wws_max_player_health * 100, c_red, c_green, c_green, 0, true, true);

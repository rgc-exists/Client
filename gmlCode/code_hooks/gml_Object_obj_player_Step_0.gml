
if(global.wws_in_online_level){
    if(!instance_exists(obj_wws_aim_target)){
        instance_create_layer(-60, -60, "Spots", obj_wws_aim_target);
    }
    if(dead == 0){
    	hp = global.wws_max_player_health;
		global.wws_stats_deaths += 1;
    }
    if(array_length(global.wws_hits_built_up) > 0){
    	for(var i = 0; i < array_length(global.wws_hits_built_up); i++){
    		scr_wws_take_hit_handler(global.wws_hits_built_up[i], global.wws_networking_socket);
    	}
	    global.wws_hits_built_up = []
    }
}


if(global.wws_in_online_level){
    gun_equipped = 6
}

audio_listener_position(x, y, 0)
if underwater
{
    target_vol = (in_water_current * lerp(0.9, 0.6, clamp((speed * 0.08), 0, 1)))
    target_vol += clamp(((speed - 12) * 0.1), 0, 1)
    target_vol = clamp(target_vol, 0, 1)
    wind_sound_fall_volume = lerp(wind_sound_fall_volume, target_vol, 0.1)
    audio_sound_gain_fx(wind_sound_fall, ((wind_sound_fall_volume * wind_sound_fall_volume) * 0.8), 0.016666666666666666)
    audio_sound_pitch(wind_sound_fall, (1 + (wind_sound_fall_volume * 0.1)))
    if ((speed > 10))
    {
        bubbleamount = clamp(((speed - 10) / 4), 0, 1)
        if ((random(1) < ((0.5 * bubbleamount) * scr_particle_multiplyer())))
            part_particles_create(global.part_sys_fx, ((x - random(20)) + 10), ((y - random(20)) + 10), global.part_type_underwBubbles, 1)
    }
}
else
{
    wind_sound_fall_volume = lerp(wind_sound_fall_volume, clamp(((abs(speed) - 10) * 0.1), 0, 1), 0.1)
    audio_sound_gain_fx(wind_sound_fall, ((wind_sound_fall_volume * wind_sound_fall_volume) * 0.9), 0.016666666666666666)
}
lookdir_smooth = lerp(lookdir_smooth, lookdir, 0.15)
realhspeed = (hspeed - bonus_speed_by_conveyor)
slither_active = (((vspeed == 0) * realhspeed) * 0.2)
if winter
    slither_active *= 0.27
if ((glitch_mode_and_dir != -1))
    slither_active = false
wind_sound_slither_volume = lerp(wind_sound_slither_volume, slither_active, 0.5)
audio_sound_gain_fx(wind_sound_slither, ((wind_sound_slither_volume * wind_sound_slither_volume) * 0.8), 0.016666666666666666)
if ((reading_file == -1))
{
    override_lookdir = false
    with (obj_persistent)
        event_user(0)
    with (obj_input_overrider_parent)
        event_user(0)
}
if (global.input_jump && (!global.input_jump_pressed) && (global.input_x == 0) && (reading_file == -1))
{
    if ((groundedremember > 0))
        holding_jump_without_moving_timer += 1
}
else
{
    glitch_mode_and_dir = -1
    holding_jump_without_moving_timer = 0
}
if ((holding_jump_without_moving_timer > 120))
{
    if ((glitch_mode_and_dir == -1))
    {
        free_right = place_free((x + 25), y)
        free_left = place_free((x - 25), y)
        free_top = place_free(x, (y - 25))
        free_bot = place_free(x, (y + 25))
        if ((!free_right) && (!free_left) && (!free_bot))
            glitch_mode_and_dir = 90
        else if ((!free_top) && (!free_bot) && (!free_left))
            glitch_mode_and_dir = 0
        else if ((!free_top) && (!free_bot) && (!free_right))
            glitch_mode_and_dir = 180
        if ((glitch_mode_and_dir != -1))
        {
            scr_set_achievement("GLITCH_IT")
            global.voice_lines_override = false
            with (obj_aivl_package_parent)
                event_user(2)
            if (!global.voice_lines_override)
            {
                if ((room != level_editor_play_mode))
                {
                    if (!(aivl_play("using_glitch_first_time", 3)))
                    {
                        if (!(aivl_play("using_glitch_2nd_time", 2)))
                        {
                            if (!(aivl_play("using_glitch_3rd_time", 1)))
                                aivl_play("using_glitch_4th_time", 1)
                        }
                    }
                }
            }
        }
    }
}
if ((glitch_mode_and_dir >= 0))
{
    if ((global.player_using_glitch_timer < 120))
        global.player_using_glitch_timer += 1
    holding_jump_without_moving_timer = 0
    groundedremember = -1
    airjumps = 1
    motion_set(glitch_mode_and_dir, 20)
    scr_dont_move_through_solid_walls()
    part_particles_create(global.part_sys_fxPlayer, ((x - 30) + random(60)), ((y + 10) + random(20)), global.part_type_zeroOne, 1)
    sound = audio_play_sound(sou_boink_a, 0.01, false)
    audio_sound_gain_fx(sound, 0.2, 0)
    audio_sound_pitch(sound, (2 + random(2)))
    if ((speed <= 0))
        glitch_mode_and_dir = -1
}
else if ((global.player_using_glitch_timer > 0))
    global.player_using_glitch_timer -= 1
if (global.input_reset && allow_restarts)
{
    if (!instance_exists(obj_performance_optimizer))
    {
        if (!instance_exists(obj_fix_heart_decision))
        {
            if (!instance_exists(obj_reset_squid_decision))
            {
                if ((victory == -1) && (dead == -1))
                {
                    if ((lockmovement <= 0))
                    {
                        global.last_death_by = -7
                        global.last_death_by_hspeed = 0
                        global.last_death_by_vspeed = 0
                        global.last_death_by_image_anlge = 0
                        scr_player_death((obj_player.direction + 180), 0)
                        global.save_speedrun_timer_level = 0
                        
                    	hp = global.wws_max_player_health;
						global.wws_stats_deaths += 1;
                    }
                }
            }
        }
    }
}
lockmovement--
if ((lockmovement > 0))
{
    global.input_x = 0
    global.input_jump = false
    global.input_jump_pressed = false
}
nomovement_timer++
if ((nomovement_timer >= 600))
    nomovement_timer = 0
particletraveldist += point_distance(x, y, xlast, ylast)
while ((particletraveldist > 5))
{
    particletraveldist -= 5
    xxp = lerp(x, xlast, random(1))
    yyp = lerp(y, ylast, random(1))
    if ((global.setting_visual_details != 0))
    {
        part_type_direction(global.part_type_playerTrail, (direction - 20), (direction + 20), 0, 0)
        part_type_speed(global.part_type_playerTrail, 0, (speed * 0.02), 0, 0)
        part_particles_create(global.part_sys_fxPlayer, ((xxp - 3) + random(6)), ((yyp - 3) + random(6)), global.part_type_playerTrail, 1)
        if speedboosted
        {
            part_type_size(global.part_type_deathBounce, 0.2, 0.3, 0, 0)
            part_particles_create(global.part_sys_fxPlayer, ((xxp - 3) + random(6)), ((yyp - 3) + random(6)), global.part_type_deathBounce, 1)
        }
        if winter
        {
            if ((groundedremember >= 0))
            {
                if ((hspeed != 0))
                {
                    if ((slither_active != 0))
                    {
                        part_type_speed(global.part_type_snow, 0, 2, 0, 0)
                        part_type_direction(global.part_type_snow, -20, 200, 0, 0)
                        part_type_life(global.part_type_snow, 5, (10 + random(50)))
                        part_type_gravity(global.part_type_snow, 0.1, 270)
                        part_particles_create(global.part_sys_fx, ((xxp - 20) + random(40)), (yyp + 15), global.part_type_snow, 1)
                        part_particles_create(global.part_sys_fx, ((xxp - 20) + random(40)), (yyp + 15), global.part_type_snow, 1)
                    }
                }
            }
        }
    }
}
bonus_speed_by_conveyor = 0
if ((dead < 0) && (victory < 0))
{
    if ((glitch_mode_and_dir < 0))
    {
        if ((reading_file == -1))
        {
            if global.language_testing_mode
                airjumps = 1
            if (!override_lookdir)
            {
                if ((global.input_x > 0))
                    lookdir = 1
                else if ((global.input_x < 0))
                    lookdir = -1
            }
            scr_move_like_a_snail(global.input_x, global.input_jump, global.input_jump_pressed, 0)
        }
        else
            scr_move_like_a_snail(0, 0, 0, 0)
        if speedboosted
        {
            if ((abs(hspeed) < 1))
            {
                speedboosted_grace_period--
                if ((speedboosted_grace_period <= 0))
                    speedboosted = false
            }
            else
            {
                speedboosted_grace_period = 6
                if global.underwater
                    hspeed += (global.input_x * 1)
                else
                    hspeed += (sign(hspeed) * 12)
                scr_dont_move_through_solid_walls()
            }
        }
        if extra_speed_mode
        {
            if ((reading_file == -1))
            {
                hspeed_prev = (x - xlast)
                if ((hspeed > 0))
                {
                    if ((hspeed_prev > 0))
                    {
                        if ((global.input_x >= 0.9))
                            hspeed = (max(hspeed, hspeed_prev) + 0.01)
                    }
                }
                if ((hspeed > 11))
                    hspeed += 0.1
                if ((hspeed < 0))
                {
                    if ((hspeed_prev < 0))
                    {
                        if ((global.input_x <= -0.9))
                            hspeed = (min(hspeed, hspeed_prev) - 0.01)
                    }
                }
                if ((hspeed < -11))
                    hspeed -= 0.1
                hspeed = clamp(hspeed, -20, 20)
                scr_dont_move_through_walls()
            }
        }
    }
}
else if ((victory >= 0))
{
    if (instance_exists(obj_destroyed_boss_parent) || instance_exists(obj_victory_delay))
    {
        scr_move_like_a_snail(0, false, false, 0)
        speed *= 0.9
    }
    else
        speed = 0
}
else
    speed = 0
if ((dead >= 0))
{
    speed = 0
    dead++
    if ((dead >= 40) || ((dead >= 10) && (global.last_death_by == -7)))
        scr_room_reset()
}
if ((victory >= 0))
{
    victory++
    if ((victory >= 15))
    {
        if ((!instance_exists(obj_destroyed_boss_parent)) && (!instance_exists(obj_victory_delay)))
        {
            if ((room == level_editor_play_mode) && (!instance_exists(obj_lvledit_save_loader)) && (!handled_custom_exit))
            {
                handled_custom_exit = true
                if (!global.inCustomCampaignPlayMode)
                    scr_fade_to_editor(global.campaignLevelIndex, false)
                else if (!instance_exists(obj_level_edit_transition))
                {
                    var old_campaign_index = global.campaignLevelIndex
                    global.campaignLevelIndex = scr_determine_next_level_index(old_campaign_index)
                    if ((global.campaignLevelIndex == -1))
                    {
                        global.campaignLevelIndex = old_campaign_index
                        scr_fade_to_room(170)
                    }
                    else
                        scr_fade_to_editor(global.campaignLevelIndex, true)
                }
            }
            else
            {
                idcollision = collision_point(x, y, obj_go_to_room, false, true)
                if global.save_speedrun_training_mode
                {
                    if instance_exists(idcollision)
                    {
                        if ((idcollision.object_index == obj_go_to_lvl_select))
                            scr_fade_to_room_ext(idcollision.go_to_room, idcollision.is_shortcut)
                    }
                    scr_fade_to_room(room)
                }
                if instance_exists(idcollision)
                    scr_fade_to_room_ext(idcollision.go_to_room, idcollision.is_shortcut)
                else
                    scr_fade_to_room(room_next(room))
            }
        }
    }
}
xlast = x
ylast = y
if ((speed > 0))
    nomovement_timer = 0
if ((gun_equipped > 0))
{
    gun_cooldown--
    speed_mult = 1
    if instance_exists(obj_in_community_level)
        speed_mult = obj_in_community_level.gun_speed_mult
    if ((gun_cooldown <= 0))
    {
        if ((dead == -1))
        {
        	if(global.wws_in_online_level){
        		gun_cooldown = 1;
        	} else {
	            if instance_exists(obj_in_community_level)
	                gun_cooldown = (5 * obj_in_community_level.gun_cooldown)
	            else
	                gun_cooldown = 5
        	}
            if ((gun_equipped == 1))
            {
                idmerk = instance_create_layer((x - (lookdir * 13)), (y - 10), "Player", obj_sh_projectile)
                idmerk.vspeed -= (20 * speed_mult)
                with (obj_hat_parent)
                    event_user(1)
            }
            else if ((gun_equipped == 2))
            {
                idmerk = instance_create_layer((x - (lookdir * 13)), (y - 10), "Player", obj_sh_projectile)
                idmerk.hspeed = ((26 * lookdir) * speed_mult)
                old_yscale = idmerk.image_yscale
                idmerk.image_yscale = idmerk.image_xscale
                idmerk.image_xscale = old_yscale
                idmerk.rotated = true
            }
            else if ((gun_equipped == 3))
            {
                idmerk = instance_create_layer((x - (lookdir * 13)), (y - 10), "Player", obj_sh_projectile)
                idmerk.vspeed = (20 * speed_mult)
            }
            else if ((gun_equipped == 4))
            {
                if instance_exists(obj_boss_p2)
                {
                    idmerk = instance_create_layer((x - (lookdir * 13)), (y - 10), "Player", obj_sh_projectile)
                    idmerk.direction = point_direction(x, y, obj_boss_p2.x, obj_boss_p2.y)
                    idmerk.image_angle = idmerk.direction
                    idmerk.speed = 20
                    idmerk.image_xscale = 0.2
                    idmerk.image_yscale = 0.2
                }
            }
            else if ((gun_equipped == 5))
            {
                idmerk = instance_create_layer((x + (lookdir * 3)), (y - 10), "Player", obj_sh_projectile)
                idmerk.hspeed = ((-26 * lookdir) * speed_mult)
                old_yscale = idmerk.image_yscale
                idmerk.image_yscale = idmerk.image_xscale
                idmerk.image_xscale = old_yscale
                idmerk.rotated = true
            }
            else if ((gun_equipped == 6))
            {
                if instance_exists(obj_wws_aim_target)
                {
                    if(mouse_check_button(mb_left)){
                        idmerk = instance_create_layer((x - (lookdir * 13)), (y - 10), "Player", obj_sh_projectile)
                        idmerk.direction = point_direction(x, y, obj_wws_aim_target.x, obj_wws_aim_target.y)
                        idmerk.image_angle = idmerk.direction
                        idmerk.speed = 10
                        idmerk.image_xscale = 0.2
                        idmerk.image_yscale = 0.2
                        idmerk.bullet_id = scr_createcampaignname(7)
					    var data = scr_wws_create_packet("ShootBullet", [idmerk.bullet_id, idmerk.x, idmerk.y, idmerk.image_angle]);
					    if(global.wws_networking_is_server){
						    for (var i = 0; i < ds_list_size(global.wws_networking_ids); i++)
						    {
						        var send_to = ds_list_find_value(global.wws_networking_ids, i);
						
						        var player = ds_map_find_value(global.wws_players_by_id, send_to);
						        scr_wws_send_packet(data, send_to, true, false);
						        
						    }
					    } else {
					    	scr_wws_send_packet(data, global.wws_networking_owner_id, true, false);
					    }
				    	buffer_delete(data)
                    }
                }
            }
        }
    }
}
if ((global.player_on_conveyor_timer > 0))
    global.player_on_conveyor_timer += 1
time++
if ((global.input_analysis_idle_timer == 1200))
{
    if ((room != AngerManagementRoom))
    {
        if ((room != level_editor_play_mode))
        {
            if ((room == T_01_first_contact))
            {
                if aivl_has_played("tutorialB_intro")
                    aivl_play("idle_in_very_first_room", 3)
            }
            lvltype = scr_level_dat_get_type(room)
            if ((lvltype != 0))
            {
                if ((lvltype != 1))
                {
                    if ((lvltype != 3))
                    {
                        if ((lvltype != 5))
                        {
                            if (!instance_exists(obj_destroyed_boss_parent))
                                aivl_play_random("idle", 2, 3)
                        }
                    }
                }
            }
        }
    }
}
if ((global.input_analysis_idle_timer == 120))
{
    if ((room != AngerManagementRoom))
    {
        if ((room != level_editor_play_mode))
        {
            lvltype = scr_level_dat_get_type(room)
            if ((lvltype != 1))
            {
                if ((lvltype != 3))
                {
                    if (!(place_free(x, (y + 2))))
                    {
                        if (place_free((x - 11), (y + 2)) || place_free((x + 11), (y + 2)))
                        {
                            if (!instance_exists(obj_destroyed_boss_parent))
                            {
                                if ((room != X_11_boss_P1))
                                {
                                    if ((room != X_12_boss_P2))
                                    {
                                        if instance_exists(obj_ai_general)
                                        {
                                            if obj_ai_general.enabled
                                            {
                                                if (!obj_ai_general.setting_combletely_disabled)
                                                {
                                                    if ((obj_ai_general.setting_ground_spike_probability > 0) || (obj_ai_general.setting_wall_spike_probability > 0) || (obj_ai_general.setting_ceiling_spike_probability > 0))
                                                    {
                                                        if ((obj_ai_general.setting_air_cat_probability <= 0))
                                                        {
                                                            if ((obj_ai_general.setting_badball_probability <= 0))
                                                            {
                                                                if ((obj_ai_general.setting_laser_probability <= 0))
                                                                    aivl_play_random("safe_on_block_corner", 3, 2)
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                        aivl_play_random("standing_on_block_corner", 3, 2)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
if ((hspeed != 0))
    started_playing = true
if started_playing
{
    if ((global.input_analysis_idle_timer < 600))
        active_time++
}
if ((infinijumptime > 0))
{
    infinijumptime--
    airjumps = 1
}

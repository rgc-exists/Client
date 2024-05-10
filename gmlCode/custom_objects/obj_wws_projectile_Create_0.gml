col = obj_levelstyler.col_snail
image_xscale = 0.1
image_yscale = 0.6
if global.underwater
{
    sound = audio_play_sound(choose(sou_UnderwShoot_01, sou_UnderwShoot_02, sou_UnderwShoot_03, sou_UnderwShoot_04), 0.8, false)
    audio_sound_gain_fx(sound, 0.1, 0)
}
else
{
    sound = audio_play_sound(choose(sou_laser_01, sou_laser_02, sou_laser_03, sou_laser_04), 0.8, false)
    audio_sound_gain_fx(sound, 0.15, 0)
}
rotated = false
underwater = instance_exists(obj_levelstyler_underwater)
udw_damping = (0.9 + random(0.05))
if ((global.save_difficulty == 1))
    udw_damping = lerp(udw_damping, 1, 0.2)
if ((global.save_difficulty == 0))
    udw_damping = lerp(udw_damping, 1, 0.4)
stronger = 0

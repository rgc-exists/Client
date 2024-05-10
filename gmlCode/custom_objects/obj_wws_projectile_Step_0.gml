if underwater
{
    if rotated
        image_xscale *= udw_damping
    else
        image_yscale *= udw_damping
    speed *= udw_damping
}
door = instance_place(x, y, obj_door_leveleditor)
glass_door = false
door_exists = (door != noone)
if door_exists
    glass_door = door.glass
if ((!(place_meeting(x, y, obj_glass))) && (!(place_free(x, y))) && (!glass_door))
{
    if global.underwater
    {
        play_sound = choose(sou_UnderwShotHitWall_01, sou_UnderwShotHitWall_02, sou_UnderwShotHitWall_03, sou_UnderwShotHitWall_04)
        sound = audio_play_sound_at(play_sound, (x + hspeed), (y + vspeed), 10, 350, 2500, 0.2, false, 0.3)
        audio_sound_gain_fx(sound, 0.3, 0)
        audio_sound_pitch(sound, 2)
    }
    else
    {
        play_sound = choose(sou_laser_hit_01, sou_laser_hit_02, sou_laser_hit_03, sou_laser_hit_04)
        sound = audio_play_sound_at(play_sound, (x + hspeed), (y + vspeed), 10, 350, 2500, 0.2, false, 0.3)
        audio_sound_gain_fx(sound, 0.13, 0)
        audio_sound_pitch(sound, (0.9 + random(0.2)))
    }
}

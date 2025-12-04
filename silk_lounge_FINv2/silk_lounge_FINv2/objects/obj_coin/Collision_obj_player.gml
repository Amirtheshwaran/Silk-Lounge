//After a second of being invincible coins are able to be grabbed
if(other.inv_timer <= (game_get_speed(gamespeed_fps) * 2.5)){
	global.coins++
	instance_destroy()
}
// Inherit the parent event
event_inherited();

if (!instance_exists(obj_player)) return;

if(reload > 180){
	var spread = 35
	var ang = point_direction(x, y, obj_player.x, obj_player.y);
	var b = instance_create_layer(x, y, "Instances", obj_enemy_bullet);
	b.direction = ang;
	b.speed     = 5;
	b.image_angle = ang
	b.image_xscale = -b.image_xscale
	
	// Bullet 2: left
	b = instance_create_layer(x, y, "Instances", obj_enemy_bullet);
	b.direction = ang - spread;
	b.speed = 5;
	b.image_angle = ang - spread
	b.image_xscale = -b.image_xscale

	// Bullet 3: right
	b = instance_create_layer(x, y, "Instances", obj_enemy_bullet);
	b.direction = ang + spread;
	b.speed = 5;
	b.image_angle = ang + spread
	b.image_xscale = -b.image_xscale
	
	reload = 0
	audio_play_sound(snd_gun, 2, false)
} else {
	reload++
}
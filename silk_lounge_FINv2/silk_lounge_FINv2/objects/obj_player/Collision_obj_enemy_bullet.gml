/*
//if run out of HP then dies (destroy event causes a restart at checkpoint)
	if(hp <= 0){
		instance_destroy()
	}
*/

//If the player is not recovering from damage or in a dash they can be damaged
if (!invuln and !isDashing) {
    
	/*
	// Lose health
    HP -= other
	*/
	
	// Start invincibility
    invuln = true
    inv_timer = game_get_speed(gamespeed_fps) * 3 //set for 3 seconds

    // Knock the player away from the enemy
    var dir = point_direction(other.x, other.y, x, y)
    var kb = hurt_knockback

    hVel = lengthdir_x(kb, dir) //bounce away from enemy
    vVel = -kb // bounce upward
	
	// Player Hit Event or collision with enemy
	var numCoins = global.coins; // how many coins to spawn

	for (var i = 0; i < numCoins; i++) {
		var c = instance_create_layer(x, y, "Instances", obj_coin);
		c.direction = irandom_range(0, 360);
		c.speed = random_range(3, 8); // random speed for spread
		c.gravity = 0.25;
		c.gravity_direction = 270;
		c.alarm[2] = inv_timer; // 5 seconds lifetime
	}
	
	//if run out of HP then dies (destroy event causes a restart at checkpoint)
	if(global.coins = 0){
		instance_destroy()
	}
	
	// Lose health
    global.coins = 0

}
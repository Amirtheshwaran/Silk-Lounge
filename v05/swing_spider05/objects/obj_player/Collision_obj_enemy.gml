//if run out of HP then dies (destroy event causes a restart at checkpoint)
if(hp <= 0){
	instance_destroy()
}

//If the player is not recovering from damage or in a dash they can be damaged
if (!invuln and !isDashing) {
    // Lose health
    hp -= other.damage

    // Start invincibility
    invuln = true
    inv_timer = game_get_speed(gamespeed_fps) * 3 //set for 3 seconds

    // Knock the player away from the enemy
    var dir = point_direction(other.x, other.y, x, y)
    var kb = hurt_knockback

    hVel = lengthdir_x(kb, dir) //bounce away from enemy
    vVel = -kb // bounce upward

}
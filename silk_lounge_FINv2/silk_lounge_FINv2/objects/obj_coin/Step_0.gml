// Only move if it has speed
if (speed != 0 || vspeed != 0) {

    // Horizontal movement
    x += lengthdir_x(speed, direction)

    // Vertical movement
    vspeed += gravity
    y += vspeed

    // Floor collision
    if (place_meeting(x, y, obj_wall)) {
        // Push the coin up until it's not colliding
        while (place_meeting(x, y, obj_wall)) {
            y -= 1
        }

        // Reverse vertical speed to bounce
        vspeed *= -0.7

        // Reduce horizontal speed
        speed *= 0.99

        // Stop very small bounces
        if (abs(vspeed) < 1) {
            vspeed = 0
        }
    }
	
	with(obj_player){
		//Makes enemy flash to show they are invincible
		if (inv_timer mod 4 == 0) {
			other.image_alpha = 0.5
		}else {
			other.image_alpha = 1
		}
	
		//When timer is up sets flash to normal and turns off invincibility
		if (inv_timer <= 0) {
			invuln = false
			other.image_alpha = 1
		}
	}
}
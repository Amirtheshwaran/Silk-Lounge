// Only move if it has speed
if (speed != 0 || vspeed != 0) {

    // Horizontal movement
    x += lengthdir_x(speed, direction);

    // Vertical movement
    vspeed += gravity;
    y += vspeed;

    // Floor collision
    if (place_meeting(x, y, obj_wall)) {
        // Push the coin up until it's not colliding
        while (place_meeting(x, y, obj_wall)) {
            y -= 1;
        }

        // Reverse vertical speed to bounce
        vspeed *= -0.7;

        // Reduce horizontal speed
        speed *= 0.95;

        // Stop very small bounces
        if (abs(vspeed) < 1) {
            vspeed = 0;
        }
    }
}
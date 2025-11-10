var _keyLeft = keyboard_check(ord("A")) //move left
var _keyRight = keyboard_check(ord("D")) //move right
var _keyUp = keyboard_check(ord("W")) //move up (swinging)
var _keyDown = keyboard_check(ord("S")) //move down (swinging)
var _keyJump = keyboard_check(vk_space) //jump button (stops swinging)
var _keyShoot = keyboard_check(ord("Q")) //Shooting button

//If the player is on the grounded they won't keep moving down
grounded = (place_meeting(x, y+1, obj_wall))
//If the player jumps onto a platform they can jump from there
if ((place_meeting(x, y+1, obj_platform))){
	grounded = true
}

//If you are on the ground you cannot stick to walls
if(grounded){
	canStick = 0
}

//onAWall
var onAWall = place_meeting(x-1, y, obj_wall) - place_meeting(x+1, y, obj_wall)

//determines if player moves right or left
//use to determine where sprite is facing
var dir = _keyRight - _keyLeft
if(_keyRight > _keyLeft){
	face = 1
} else if (_keyRight < _keyLeft) {
	face = -1
}

//Based on the state the player can perform different actions
//Normal~ allows jumping and movement + shooting L or R
//	it switches when jumping onto the side of a wall(wallStick)
//		or clicking on one(swinging)
//Swing~ Shoot L or R, hit and stick to wall, or or jump off into normal mode
//WallStick~ jumping off the wall or shooting in the opposite direction
switch(state){
	case pState.normal:
	{
		//move in direction and accelerates
		hVel += dir * walkAcceleration
		frame++
		if((image_index == 1) and frame >= 15){
			image_index = 0
			frame = 0
		} else if(frame >= 15){
			image_index = 1
			frame = 0
		}
		
		//slows movement if not moving left or right
		if(dir == 0){
			//value for when grounded
			var hFriction = hFrictionGround
			image_index = 0
			
			//if the player is in the air they use air friction instead
			if(!grounded){ 
				hFriction = hFrictionAir
			}
			
			//smoothly slows player down
			hVel = Approach(hVel, 0, hFriction)
		}
		
		//Only moves up to max walk speed
		hVel = clamp(hVel, -walkSpeed, walkSpeed)
		//keeps on ground if in air
		vVel += gravity_
		
		//***************************
		//			Dash			*
		//***************************
		if(!isDashing && grounded){
		dashTimer = -2 //After being touching the ground you can dash again
		}

		// Dash input (press SHIFT to dash)
		if (keyboard_check_pressed(vk_shift) && !isDashing && (dashTimer == -2)) {
			isDashing = true;
			dashTimer = dashTime;

			// Dash in current horizontal direction
			if (keyboard_check(vk_right)){
				dashDir = 0 //dash right
			} else if (keyboard_check(vk_left)){ 
				dashDir = 180 //dash left
			} else {	
				dashDir = image_xscale == 1 ? 0 : 180 // fallback facing dir
			} 
		}

		if (isDashing) {
			// Move quickly in dash direction
			hVel = lengthdir_x(dashSpeed, dashDir)
			vVel = 0

			dashTimer--

			// End dash after timer expires
			if (dashTimer <= 0) {
				isDashing = false
				dashTimer = -1 //when dash ends you can't use it again until touching the ground
			}
		}//end of dash code
		
		//can only jump when you are on the ground
		if (_keyJump) && (grounded){
			grounded = false
			vVel = -jumpSpeed
		}
		
		//If you are jump onto a wall you will stick to it to perform wall jumps
		if((onAWall != 0) and (onAWall != canStick)){
			state = pState.wallStick
		}
		
		//If player clicks on a piece of wall they can use it as a grapple point
		//Checks if the mouse has been clicked
		if(mouse_check_button_pressed(mb_left)){
			//Set's rope end point
			grappleX = mouse_x
			grappleY = mouse_y
			//If the grapple point is on a wall it forms the rope
			if (place_meeting(grappleX, grappleY, obj_wall) or place_meeting(grappleX, grappleY, obj_platform))
            {
				//Set the starting point of the rope (the player)
				ropeX = x
				ropeY = y
				//Resets/sets rope's velocity
				ropeAngleVelocity = 0
				//Set's how long the rope is and the angle
				//So that it goes from player to the clicked spot
				ropeAngle = point_direction(grappleX, grappleY, ropeX, ropeY)
				ropeLength = point_distance(grappleX, grappleY, ropeX, ropeY)
				state = pState.swing //changes state to swinging
            }
		}
		
	}break;
	
	//Add comments
	case pState.swing:
	{
		//Tracks the angle that the rope is in
		var _ropeAngleAcceleration = -.2 * dcos(ropeAngle) //Angle that the rope is moving into
		_ropeAngleAcceleration += (dir) * .08 //Player movement
		image_index = 3
		
		canStick = 0
		
		//Allows movement up and down the rope
		ropeLength += (_keyDown - _keyUp) * 2
		ropeLength = max(ropeLength, 5)
		
		//Tracks angle between end of rope and grapple of rope
		ropeAngleVelocity += _ropeAngleAcceleration
		ropeAngle += ropeAngleVelocity
		ropeAngleVelocity *= .99 //Slows down when not moving
		
		//Rope end move with the grapple point being reangled
		ropeX = grappleX + lengthdir_x(ropeLength, ropeAngle)
		ropeY = grappleY + lengthdir_y(ropeLength, ropeAngle)
		
		//Player moves with the rope
		hVel = ropeX - x
		vVel = ropeY - y
		
		//When jumping give height and stop using the rope
		if(_keyJump){
			state = pState.normal
			vSpeed = -jumpSpeed
			image_index = 0
		}
		
	}break;
	
	case pState.wallStick:
	{
		//Stop movement as player sticks to the wall
		hVel = 0
		vVel = 0
		
		//If jumping the player moves into opposite direction of wall they are on
		//(To feel they are kicking off it)
		if(_keyJump){
			hVel = walkAcceleration * 2 * onAWall
			vVel -= jumpSpeed
			image_index = 0
			canStick = onAWall
			state = pState.normal
		}
		
		//allows player to hit behind them
		dir = onAWall
	}break;
}

//*******************************
//			Collision			*
//*******************************
//Check for horizontal (x) collisons
if (place_meeting(x + hVel, y, obj_wall))
{
    var _hStep = sign(hVel);
    
    // Move player up to wall
    while (!place_meeting(x + _hStep, y, obj_wall))
    {
        x += _hStep;
    }
    
    if(!place_meeting(x + hVel, y, obj_platform)){
		//Stop horizontal movement only when hitting side walls
		hVel = 0
	}
    
	//Stops player from swinging through walls
    if (state == pState.swing)
    {
        ropeAngle = point_direction(grappleX, grappleY, x, y);
        ropeAngleVelocity = 0;
    }
}

x += hVel

//Check for vertical (y) collisons
if(place_meeting(x, y + vVel, obj_wall)){
	
	//Stops falling through floor
	vVel = 0
	
	//Stops from moving through floor when extending rope (Doesn't really do the same for going up)
    if (state == pState.swing)
    {
		//If ropex/y -> goes through floor if x/y -> slidey movement
		ropeAngle = point_direction(grappleX, grappleY, x, y)
        ropeAngleVelocity = 0
		
    }
	
}

//Allows jumping above platform but not falling through
if(!place_meeting(x, y + vVel, obj_platform)){
		//does nothing when jumping above platform
} else {
	if(y < obj_platform.y - 40){
		vVel = 0
	}
}

y += vVel

//*******************************
//			Shooting			*
//*******************************
//Shooting mechanic
if ((canShoot) and (_keyShoot)){
	instance_create_layer(x, y, "Instances", obj_playBullet);
	canShoot = false;
	//alarm activates after this many game updates (60/2) means every 30 game updates
	alarm[1] = game_get_speed(gamespeed_fps)/2;
}

//***************************
//			Facing			*
//***************************
//Turns player left and right
if((dir != 0)){
	image_xscale = dir
}


//*******************************
//			Invincible			*
//*******************************
//Makes it so player can't take damage for a time after being hit
if (invuln) {
    inv_timer--;
    
	//Makes enemy flash to show they are invincible
	if (inv_timer mod 4 == 0) {
		image_alpha = 0.5;
	}else {
		image_alpha = 1;
	}
	
	//When timer is up sets flash to normal and turns off invincibility
	if (inv_timer <= 0) {
        invuln = false;
		image_alpha = 1;
    }
	
}





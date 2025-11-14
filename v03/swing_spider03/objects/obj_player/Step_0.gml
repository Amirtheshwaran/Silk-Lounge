var _keyLeft = keyboard_check(ord("A")) //move left
var _keyRight = keyboard_check(ord("D")) //move right
var _keyUp = keyboard_check(ord("W")) //move up (swinging)
var _keyDown = keyboard_check(ord("S")) //move down (swinging)
var _keyJump = keyboard_check(vk_space) //jump button (stops swinging)
var _keyShoot = keyboard_check(ord("Q")) //Shooting button

//If the player is on the grounded they won't keep moving down
grounded = (place_meeting(x, y+1, obj_wall))

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
		
		if (_keyJump) && (grounded){
			grounded = false
			vVel = -jumpSpeed
		}
		
		//If player clicks on a piece of wall they can use it as a grapple point
		//Checks if the mouse has been clicked
		if(mouse_check_button_pressed(mb_left)){
			//Set's rope end point
			grappleX = mouse_x
			grappleY = mouse_y
			//If the grapple point is on a wall it forms the rope
			if (place_meeting(grappleX, grappleY, obj_wall))
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
				state = pState.swing
            }
		}
		
	}break;
	
	//Add comments
	case pState.swing:
	{
		//Tracks the angle that the rope is in
		var _ropeAngleAcceleration = -.2 * dcos(ropeAngle) //Angle that the rope is moving into
		_ropeAngleAcceleration += (dir) * .08 //Player movement
		
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
		}
		
	}break;
}

//Make Comments
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
	} else {

	}
    
    if (state == pState.swing)
    {
        ropeAngle = point_direction(grappleX, grappleY, x, y);
        ropeAngleVelocity = 0;
    }
}

x += hVel

//Check for vertical (y) collisons
if(place_meeting(x, y + vVel, obj_wall)){
	//Sets to 1: going down, -1:going up, 0:not moving
	var _vStep = sign(vVel)
	
	
	if(!place_meeting(x, y + vVel, obj_platform)){
		//Stop vertical motion when hitting floor or ceiling
		vVel = 0
	} else {
		if(y < obj_platform.y - 40){
			vVel = 0
		}
	}
    
    //Set grounded = true when hitting the floor (not ceiling)
    if (_vStep > 0){
        grounded = true
    }
	
    if (state == pState.swing)
    {
		//If ropex/y -> goes through floor if x/y -> slidey movement
		ropeAngle = point_direction(grappleX, grappleY, x, y)
        ropeAngleVelocity = 0
		
    }
	
}

y += vVel

//Shooting mechanic
if ((canShoot) and (_keyShoot)){
	instance_create_layer(x, y, "Instances", obj_playBullet);
	canShoot = false;
	//alarm activates after this many game updates (60/2) means every 30 game updates
	alarm[1] = game_get_speed(gamespeed_fps)/2;
}

//Turns player left and right
if(dir != 0){
	image_xscale = dir
}


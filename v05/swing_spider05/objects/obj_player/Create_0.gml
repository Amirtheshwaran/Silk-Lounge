//Horizontal and Vertical velocity
hVel = 0
vVel = 0

image_speed = 0
frame = 0
face = 1 //1=Right -1=Left

//Max horizontal speed and horizontal acceleration
walkSpeed = 4
walkAcceleration = 1.5

//Friction when grounded or in air
hFrictionGround = .5 //slow player on ground
hFrictionAir = 0 //air control

jumpSpeed = 8 //jump velocity

gravity_ = .2 //moves player down

state = pState.normal //determines start state

//shooting
canShoot = true //turned on and off for reload
reloadTime = 0 //how long until player can shoot again
canStick = 0 //-1>left, 0>none, 1>right

hp = 3 //hit points

// Dash
isDashing = false //when dashing can't dash again or get hurt
dashSpeed = 15 //sets how fast the dash goes
dashTime = 15 // frames the dash is active for
dashTimer = 0 //timer that counts down how long the dash lasts, 
			  //-1 means you need to touch the ground to get the dash back,
			  //-2 means you have touched the ground and can dash again
dashDir = 0 // direction of dash

//Knockback/Damage
invuln = false //invulnerable
inv_timer = 0 // Counts down invincibility time
hurt_knockback = 10 // Strength of knockback

enum pState{
	normal,
	swing,
	wallStick
}
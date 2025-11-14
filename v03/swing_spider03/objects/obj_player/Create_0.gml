//Horizontal and Vertical velocity
hVel = 0
vVel = 0

image_speed = 0
frame = 0
face = 1 //1=Right -1=Left

//Max horizontal speed and horizontal acceleration
walkSpeed = 3
walkAcceleration = 1.5

//Friction when grounded or in air
hFrictionGround = .5 //slow player on ground
hFrictionAir = 0 //air control

jumpSpeed = 8 //jump velocity

gravity_ = .2 //moves player down

state = pState.normal //determines start state
canShoot = true //turned on and off for reload
reloadTime = 0 //how long until player can shoot again

enum pState{
	normal,
	swing,
	wallStick
}
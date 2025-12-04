//Moves in the direction it's sprite is facing at movespeed
x -= moveSpeed * dir
image_xscale = dir
image_speed = .25

if(hp <= 0){
	instance_destroy()
}
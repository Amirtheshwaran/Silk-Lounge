//Moves in the direction it's sprite is facing at movespeed
x -= moveSpeed * dir
image_xscale = dir

if(hp <= 0){
	instance_destroy()
}
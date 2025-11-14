//Sets movement to be where the player is facing (only when first shot)
if(move == 0){
	with(obj_player){
		other.move = 10 * face
		other.image_xscale = face
	}
}

//Moves bullet in a direction
x += move
image_speed = .25 //How fast the bullet switches frames

//destroys bullet if it outside room
if (x > room_width || x < 0) {
    instance_destroy()
}
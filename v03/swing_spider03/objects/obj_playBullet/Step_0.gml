if(move == 0){

	with(obj_player){
		other.move = 10 * face
		other.image_xscale = face
	}

}

x += move
image_speed = .25

if (x > room_width || x < 0) {
    instance_destroy();
}
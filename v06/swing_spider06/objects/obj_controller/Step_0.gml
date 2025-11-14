//cheats
(keyboard_check( vk_tab)){
	if(keyboard_check_pressed(ord("N"))){
		//Hold tab and press n sends to next room
		room_goto_next()
	}
	
	if(keyboard_check_pressed(ord("R"))){
		//Hold tab and press r to reset
		room_restart()
	}
	
	if(keyboard_check_pressed(ord("C"))){
		//Hold tab and press c to add coins
		with(obj_player){
			coins++
		}
	}
}
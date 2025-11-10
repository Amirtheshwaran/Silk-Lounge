//cheats
(keyboard_check( vk_tab)){
	if(keyboard_check_pressed(ord("N"))){
		//Hold tab and press n sends to next room
		room_goto_next()
	}
}
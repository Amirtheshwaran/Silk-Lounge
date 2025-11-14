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
	
	if(keyboard_check_pressed(vk_escape)){
		//Hold tab and press esc toclose game
		game_end()
	}
}

var cx = camera_get_view_x(view_camera[0]);

// far mountains move slow
layer_x("bg_far", cx * 0.2);

// mid buildings
layer_x("bg_near", cx * -0.3);

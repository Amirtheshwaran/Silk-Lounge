/// Toggle pause
if (keyboard_check_pressed(vk_escape)) {
    global.paused = !global.paused;
	
    if (global.paused == true){
        // Capture screen as a surface FIRST
		var w = surface_get_width(application_surface);
		var h = surface_get_height(application_surface);
		
		pause_surf = surface_create(w, h);
		
        surface_set_target(pause_surf)
		draw_surface(application_surface, 0, 0);
        surface_reset_target()
        
        // Deactivate all EXCEPT audio and menu objects
        instance_deactivate_all(true);
        //instance_activate_object(obj_audio);  // ← CRITICAL: Keep audio active!
        //instance_activate_object(obj_menu);
        instance_activate_object(obj_pausemenu);
        
    } else {
        // Unfreezes all instances
        instance_activate_all();
    }
}

// While paused - handle menu keys
if (global.paused) {
    if (keyboard_check_pressed(ord("R"))) {
        global.paused = false;
        instance_activate_all();
		//global.score = 0;
		global.coins = 0
		//global.timer = 0
		//global.lives =  global.startLife;
		//audio_stop_sound(snd_stage_intro)
        room_restart()
		//room_restart()
    }

	if (keyboard_check_pressed(ord("M"))) {
        global.paused = false;
        instance_activate_all();
		global.score = 0;
		global.coins = 0
		global.timer = 0
		//global.score = 0;
		//global.lives = global.startLife;
		//global.boss_timer = 0
		//audio_stop_sound(snd_stage_intro)
		//audio_stop_sound(snd_stage_bgm)
		//audio_stop_sound(snd_jdTheme)
		//audio_play_sound(snd_menu_bgm,10,true)
		instance_destroy(self)
		audio_stop_all()
		audio_play_sound(snd_title, 1, true)
        room_goto(rm_menu_0);
    }
	
}
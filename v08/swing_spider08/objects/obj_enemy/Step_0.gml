if(hp <= 0){
	instance_destroy()
}

if(instance_exists(obj_player)){
	var dist = distance_to_object(obj_player)


	switch(state){
		case eState.patrol:{
			if (dist < attackRange) {
				state = eState.chase
				path_end()
			}
		}break;
	
		case eState.chase:{
			direction = point_direction(x, y, obj_player.x, obj_player.y);

			speed = moveSpeed
		
			if (dist > attackRange * 1.5) {
				state = eState.returning
			}
		
		}break;
	
		case eState.returning:{
			var dir = point_direction(x, y, home_x, home_y);
			motion_set(dir, moveSpeed);

			if (dist < attackRange) {
				state = eState.chase
			}

			if (point_distance(x, y, home_x, home_y) < 4) {
				path_start(pathName, moveSpeed, path_action_restart, true);
				state = eState.patrol
			}
		
		}break;
	}

}
hp = 3
moveSpeed = 3
damage = 1
attackRange = 350

pathName = test_path

path_start(pathName, moveSpeed, path_action_restart, true)

home_x = x;
home_y = y;

state = eState.patrol

enum eState{
	patrol,
	chase,
	returning
}
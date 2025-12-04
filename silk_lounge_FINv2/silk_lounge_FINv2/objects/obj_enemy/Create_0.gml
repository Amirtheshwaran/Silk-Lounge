hp = 3
moveSpeed = 3
damage = 1
attackRange = 350

home_x = x;
home_y = y;

state = eState.patrol

enum eState{
	patrol,
	chase,
	returning
}

pathName = test_path
global._keyLeft_ = (ord("A")) //move left
global._keyRight_ = (ord("D")) //move right
global._keyUp_ = (ord("W")) //move up (swinging)
global._keyDown_ = (ord("S")) //move down (swinging)

global._keyShoot_ =(ord("Q")) //Shooting button

//Movement State
enum movState{
	wasd,
	arrows
}

//Shoot State
enum shoState{
	q,
	e,
	rClick
}

//Shader State
enum shaState{
	normal,
	hedgehog,
	plumber
}

global.movementState = movState.wasd

global.shootState = shoState.q

global.shaderState = shaState.normal
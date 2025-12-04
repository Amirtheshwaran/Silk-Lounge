function save_game(){
	var _struct =
	{
		move0: global._keyLeft_,
		move1: global._keyRight_,
		move2: global._keyUp_,
		move3: global._keyDown_,
		moveS: global.movementState,
		shoot0: global._keyShoot_,
		shootS: global.shootState,
		shaderS : global.shaderState
	};
	
	var _string = json_stringify(_struct)
	
	var _file = file_text_open_write("save.txt")
	
	file_text_write_string( _file, _string)
	
	file_text_close(_file)
}

function load_game(){

	if(file_exists("save.txt")){
		var _file = file_text_open_read("save.txt")
		
		var _json = file_text_read_string(_file)
		
		var _struct = json_parse(_json)
		
		global._keyLeft_ = _struct.move0
		global._keyRight_ = _struct.move1
		global._keyUp_ = _struct.move2
		global._keyDown_ = _struct.move3
		global.movementState = _struct.moveS
		global._keyShoot_ = _struct.shoot0
		global.shootState = _struct.shootS
		global.shaderState = _struct.shaderS
		
		file_text_close(_file)
	}
	
}
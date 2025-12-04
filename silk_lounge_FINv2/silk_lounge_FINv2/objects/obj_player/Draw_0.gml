if (state == pState.swing){ 
	draw_line_width(grappleX, grappleY, ropeX, ropeY,2) 
	draw_sprite_ext(spr_arm, 0, x, y, 1, 1, ropeAngle + 90, c_white, 1)
}

if(global.shaderState == shaState.hedgehog){
	shader_set(sh_hedgehog)
} else if(global.shaderState == shaState.plumber){
	shader_set(sh_plumber)
} else{
	//No Shader
	shader_reset()
}

draw_self()

shader_reset()
//draw_text(x + 20, y - 40, "State: " + string(state) + "\nGrounded: " + string(grounded) + "\nHP: " + string(hp) + "\nCoin: " + string(coins));
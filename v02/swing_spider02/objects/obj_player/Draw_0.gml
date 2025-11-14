if (state == pState.swing){ 
	draw_line_width(grappleX, grappleY, ropeX, ropeY,2) 
}

draw_self()
draw_text(x + 20, y - 40, "State: " + string(state) + "\nGrounded: " + string(grounded));
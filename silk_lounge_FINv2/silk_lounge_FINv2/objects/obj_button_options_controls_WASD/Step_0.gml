// Inherit the parent event
event_inherited();

if(global.movementState == movState.wasd){
	sprite_index = spr_buttonSelected
} else {
	sprite_index = spr_button
}
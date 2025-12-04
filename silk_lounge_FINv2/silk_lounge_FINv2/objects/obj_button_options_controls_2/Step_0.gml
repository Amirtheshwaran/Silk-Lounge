// Inherit the parent event
event_inherited();

if(global.shootState == shoState.rClick){
	sprite_index = spr_buttonSelected
} else {
	sprite_index = spr_button
}
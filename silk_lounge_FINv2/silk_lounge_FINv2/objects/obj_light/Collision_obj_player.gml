if(fallThrough = 1){
// Bounce the player upward (or away)
other.vVel = -8;       // vertical bounce
other.hVel *= -1;      // optional "kick away"
other.dashTimer = -2

// Change to broken sprite
image_index = 1

// Disable collision so player falls through afterward
fallThrough = 0
audio_play_sound(snd_break, 2,false)
}
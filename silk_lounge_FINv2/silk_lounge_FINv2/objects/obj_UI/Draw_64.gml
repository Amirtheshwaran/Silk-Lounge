if((room == rm_level1) or (room == rm_level2) or (room == rm_boss)){
// Draw score
draw_text(xoff, yoff, "Score: " + string(global.score));

// Draw coins
draw_text(xoff, yoff + 24, "Coins: " + string(global.coins));

// Draw time
//var seconds = floor(current_time / 1000);
seconds = floor(global.timer / room_speed);

if (((seconds%60) >= 0) && ((seconds%60) <= 9)){
    draw_text(xoff, yoff + 48, "Time: " + string((floor(seconds / 60))) + ":0" + string((seconds%60)))
} else {
    draw_text(xoff, yoff + 48, "Time: " + string((floor(seconds / 60))) + ":" + string((seconds%60)))
}

}
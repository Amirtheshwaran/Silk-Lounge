draw_set_color(c_white);
draw_text(100, 50, "HIGH SCORES");

for (var i = 0; i < 10; i++) {
    var entry = global.highscores[i];
    draw_text(100, 100 + i * 32, entry.name + "   " + string(entry.score));
}
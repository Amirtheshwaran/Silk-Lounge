draw_set_color(c_white)
draw_text(100, 100, "Score: " + string(global.score))
draw_text(100, 150, "ENTER NAME:");
draw_text(100, 200, "Up/Down~Choose Letters \nLeft/Right~Switch Letters \nPress Enter When Done")

for (var i = 0; i < 3; i++) {
    var col = (i == index) ? c_yellow : c_white;
    draw_set_color(col);
    draw_text(110 + 100 + i * 32, 150, name_letters[i]);
}
var msg = "You Win! \nPress m to return to main menu";
var w = display_get_gui_width();
var h = display_get_gui_height();

draw_text(w / 2 - string_width(msg)/2, h / 2 - string_height(msg)/2, msg);
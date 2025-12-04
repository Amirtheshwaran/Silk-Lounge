if (!global.paused) exit;

var w = display_get_gui_width();
var h = display_get_gui_height();

// draw the captured screen first
draw_surface_stretched(pause_surf, 0, 0, w, h)

// dark overlay
draw_set_alpha(0.7);
draw_set_color(c_black);
draw_rectangle(0, 0, w, h, false);
draw_set_alpha(1);

// draw pause text
draw_set_color(c_white);
//draw_set_halign(fa_center);
//draw_set_valign(fa_middle);

draw_text(w*0.5, h*0.5 - 40, "GAME PAUSED");
draw_text(w*0.5, h*0.5, "Press ESC to Resume");
draw_text(w*0.5, h*0.5 + 40, "Press R to Restart");
draw_text(w*0.5, h*0.5 + 80, "Press M for Main Menu");
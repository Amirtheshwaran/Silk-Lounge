/// @desc Draws Boss's HP
var boss_hp_meter = 0

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

var p = noone;
if (instance_exists(obj_enemyWasp)) {
    p = instance_find(obj_enemyWasp, 0);
}

if (instance_exists(p)) {
    var meter_x = 630;
    var meter_y = gui_h - 30;
    var meter_width = 660;
    var meter_height = 20;

    // background
    draw_set_color(c_dkgray);
    draw_rectangle(meter_x, meter_y, meter_x + meter_width, meter_y + meter_height, false);

    // fill
    var fill = clamp(p.hp / 8, 0, 1) * meter_width;
    draw_set_color(c_red)
    draw_rectangle(meter_x, meter_y, meter_x + fill, meter_y + meter_height, false);

    // outline
    draw_set_color(c_white);
    draw_rectangle(meter_x, meter_y, meter_x + meter_width, meter_y + meter_height, true);

    // label
    draw_set_color(c_white);
    draw_text(780, meter_y - 3, "Raymond HP");
}
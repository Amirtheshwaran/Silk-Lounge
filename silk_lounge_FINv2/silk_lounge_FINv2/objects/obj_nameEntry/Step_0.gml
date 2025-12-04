// Move letter selection
if (keyboard_check_pressed(vk_right)) index = clamp(index + 1, 0, 2);
if (keyboard_check_pressed(vk_left))  index = clamp(index - 1, 0, 2);

// Change letters
if (keyboard_check_pressed(vk_up)) {
    var ord_val = ord(name_letters[index]);
    ord_val = (ord_val == ord("Z")) ? ord("A") : ord_val + 1;
    name_letters[index] = chr(ord_val);
}
if (keyboard_check_pressed(vk_down)) {
    var ord_val = ord(name_letters[index]);
    ord_val = (ord_val == ord("A")) ? ord("Z") : ord_val - 1;
    name_letters[index] = chr(ord_val);
}

// Confirm (Enter)
if (keyboard_check_pressed(vk_enter)) {
    var final_name = name_letters[0] + name_letters[1] + name_letters[2];
    add_highscore(final_name, global.score);
    global.score = 0;
	global.coins = 0
	global.timer = 0
	room_goto(rm_menu_0)
}
if (keyboard_check_pressed(vk_tab)) { tooltips_on = !tooltips_on; }

if (keyboard_check_pressed(ord("R"))) {	game_restart();	}

if (keyboard_check_pressed(vk_escape)) { game_end(); }

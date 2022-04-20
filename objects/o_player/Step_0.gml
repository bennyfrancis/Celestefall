#region Input

	kLeft	= keyboard_check(vk_left)			||	keyboard_check(ord("A"));
	kRight	= keyboard_check(vk_right)			||	keyboard_check(ord("D"));
	kDown	= keyboard_check_pressed(vk_down)	||	keyboard_check_pressed(ord("S"));
	kJump	= keyboard_check_pressed(vk_up)		||	keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("W"));
	kReset	= keyboard_check_pressed(ord("R"));
#endregion

#region Movement

	var _dir = kRight - kLeft;
	xspd = 3 * _dir;

	// Gravity
	yspd = min(yspd+grav, maxfallspd);

	// Jumping
	if (on_solid() && kJump) {
		yspd = jumpspd;
	}

	// Move and collide
	move_x(xspd);
	move_y(yspd, function(_inst) {
		collide_y();
		show_debug_message("Vertical collision with: " + object_get_name(_inst.object_index));
	});
	
	//drop through one-way platforms
	if (kDown && place_meeting(x, y+1, o_solid_oneway)) {
		y += 2;	
	}
	
#endregion

#region Animation

	if (_dir != 0) {
		image_xscale = _dir;
		sprite_index = s_player_run;	
	}

	if (on_solid()) {
		if (xspd == 0 && _dir == 0) {
			sprite_index = s_player_idle;
		}
	} else {
		sprite_index = yspd < 0 ? s_player_jump : s_player_fall;
	}
	
#endregion

if (kReset) {
	game_restart();	
}

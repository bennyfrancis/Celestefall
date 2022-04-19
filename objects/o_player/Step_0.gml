#region Input

	kLeft	= keyboard_check(vk_left)		|| keyboard_check(ord("A"));
	kRight	= keyboard_check(vk_right)		|| keyboard_check(ord("D"));
	kJump	= keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("W"));

#endregion

#region Movement

	var _dir = kRight - kLeft;
	xspd = 3 * _dir;

	// Gravity
	yspd = min(yspd+grav, maxfallspd);

	// Jumping
	if (on_ground() && kJump) {
		yspd = jumpspd;
	}

	// Move and collide
	move_x(xspd);
	move_y(yspd, function(_inst) {
		collide_y();
		show_debug_message("Vertical collision with: " + object_get_name(_inst.object_index));
	});
	
#endregion

#region Animation

	if (_dir != 0) {
		image_xscale = _dir;
		sprite_index = s_player_run;	
	}

	if (on_ground()) {
		if (xspd == 0 && _dir == 0) {
			sprite_index = s_player_idle;
		}
	} else {
		sprite_index = yspd < 0 ? s_player_jump : s_player_fall;
	}
	
#endregion


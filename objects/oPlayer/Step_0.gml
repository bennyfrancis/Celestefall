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
	moveX(xspd);
	moveY(yspd, function(_inst) {
		collideY();
		show_debug_message("Vertical collision with: " + object_get_name(_inst.object_index));
	});
	

#endregion
#region Animation


	if (_dir != 0) {
		image_xscale = _dir;
		sprite_index = sPlayer_run;	
	}

	if (on_ground()) {
		if (xspd == 0 && _dir == 0) {
			sprite_index = sPlayer_idle;
		}
	} else {
		sprite_index = yspd < 0 ? sPlayer_jump : sPlayer_fall;
	}
	

#endregion


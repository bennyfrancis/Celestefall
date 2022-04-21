#region Input

	k_left	= keyboard_check(vk_left)			||	keyboard_check(ord("A"));
	k_right	= keyboard_check(vk_right)			||	keyboard_check(ord("D"));
	k_down	= keyboard_check_pressed(vk_down)	||	keyboard_check_pressed(ord("S"));
	k_jump	= keyboard_check_pressed(vk_up)		||	keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("W"));
	k_reset	= keyboard_check_pressed(ord("R"));
	
#endregion

#region Movement

	var _dir = k_right - k_left;
	xspd = 3 * _dir;

	// Gravity
	yspd = min(yspd+grav, maxfallspd);

	// Jumping
	if (on_solid() && k_jump) {
		yspd = jumpspd;
	}

	// Move and collide
	move_actor_x(xspd);
	move_actor_y(yspd, function(_inst) {
		collide_y();
		show_debug_message("Vertical collision with: " + object_get_name(_inst.object_index));
	});
	
	//drop through one-way platforms
	if (k_down && place_meeting(x, y+1, o_solid_oneway)) {
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

if (k_reset) {
	game_restart();	
}

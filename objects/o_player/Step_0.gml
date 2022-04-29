#region Input

	k_left	= keyboard_check(vk_left)			||	keyboard_check(ord("A"));
	k_right	= keyboard_check(vk_right)			||	keyboard_check(ord("D"));
	k_down	= keyboard_check_pressed(vk_down)	||	keyboard_check_pressed(ord("S"));
	k_jump	= keyboard_check_pressed(vk_up)		||	keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("W"));
	k_cling	= keyboard_check(vk_shift);
	
#endregion

#region Movement

	var _dir = k_right - k_left;
	
	if (!clinging) { 
		
		// Movement
		xspd = 3 * _dir;
		
		// Gravity
		yspd = min(yspd+grav, maxfallspd);

		// Jumping
		if (on_solid() && k_jump) {
			yspd = jumpspd;
		}
	} else {
		yspd = 0;
		yspd_remainder = 0;
	}

	// Wall cling
	if (k_cling) {

		cling_inst = instance_place(x+1,y,o_solid);
		
		
		if (cling_inst == noone) {
			cling_inst = instance_place(x-1,y,o_solid);
			if (cling_inst != noone) { cling_dir = 1 };
		} else { 
			cling_dir = -1;	
		}
		
		if (cling_inst != noone) {
			clinging = true;
		} else {
			clinging = false;
		}
		
	} else {
		clinging = false;
	}

	// Move and collide
	move_x(xspd);
	move_y(yspd, function(_inst) {
		collide_y();
		show_debug_message("Vertical collision with: " + object_get_name(_inst.object_index));
	});
	
	// Drop through one-way platforms
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
	
	if (clinging) {
		sprite_index = s_player_cling;
		image_xscale = cling_dir;
	}
	
#endregion

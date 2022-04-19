//INPUT\\
kLeft	= keyboard_check(vk_left)		|| keyboard_check(ord("A"));
kRight	= keyboard_check(vk_right)		|| keyboard_check(ord("D"));
kJump	= keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("W"));

//RUN\\
var _dir = kRight - kLeft;
xspd = 3*_dir;

//GRAVITY\\
yspd = min(yspd+grav, maxfallspd);

//JUMPING\\
if (on_ground() && kJump) {
	yspd = jumpspd;
}

//MOVE AND COLLIDE\\
moveX(xspd,collideX);
moveY(yspd,collideY);

//SPRITE HANDLING\\
if (_dir != 0) {
	image_xscale = _dir;
	sprite_index = sPlayer_run;	
}

if (on_ground()) {
	if (xspd == 0 && _dir == 0) {
		sprite_index = sPlayer_idle;
	}
} else {
	if (yspd < 0) {
		sprite_index = sPlayer_jump;
	} else {
		sprite_index = sPlayer_fall;
	}
}


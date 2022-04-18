//INPUT\\
kLeft	= keyboard_check(vk_left)		|| keyboard_check(ord("A"));
kRight	= keyboard_check(vk_right)		|| keyboard_check(ord("D"));
kJump	= keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("W"));


//RUN SPEED\\
var _dir = kRight - kLeft;
xspd = 3*_dir;

//FALLING\\
if (!on_ground) {
	yspd = min(yspd+grav, maxfallspd);
}

//JUMPING\\
if (on_ground && kJump) {
	yspd = jumpspd;
}

moveX(xspd,collideX);

moveY(yspd,collideY);

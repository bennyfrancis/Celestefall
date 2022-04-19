//INIT\\
xspd = 0;
xspd_remainder = 0;

yspd = 0;
yspd_remainder = 0;

//MOVEMENT FUNCTIONS\\
function moveX(_xspd,collision_event = function() {}) {
	xspd_remainder += _xspd;
	var _move = floor(xspd_remainder);
	
	if (_move != 0) {
		xspd_remainder -= _move;
		var _dir = sign(_move);

		while (_move != 0) {
			if (!place_meeting(x+_dir,y,oSolid)) {
				x += _dir;
				_move -= _dir;
			} else {
				collision_event();
				break;
			}	
		}
	}
}

function moveY(_yspd,collision_event = function() {}) {
	yspd_remainder += _yspd;
	var _move = floor(yspd_remainder);
	
	if (_move != 0) {
		yspd_remainder -= _move;
		var _dir = sign(_move);

		while (_move != 0) {
			if (!place_meeting(x,y+_dir,oSolid)) {
				y += _dir;
				_move -= _dir;
			} else {
				collision_event();
				break;
			}
		}
	}
}

//COLLISION HANDLING\\
function collideX() {
	xspd = 0;
	xspd_remainder = 0;
}

function collideY() {
	yspd = 0;
	yspd_remainder = 0;
}


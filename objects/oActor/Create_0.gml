//INIT\\
xspd = 0;
xspd_remainder = 0;

yspd = 0;
yspd_remainder = 0;

dir = 1;

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

//check to see if the actor is riding a given solid
//add additional parameters here for actions such as clinging, wall sliding, etc
function is_riding(solid) {
	//when on top
	if (place_meeting(x,y+1,solid)) {
		return true;
	}//when underneath
	else if (place_meeting(x,y-1,solid) && sign(solid.yspd) == 1) {
		return true;
	}// when moving the same direction horizontally
	else if (place_meeting(x+sign(solid.xspd),y,solid) && sign(xspd) == sign(solid.xspd))
	{
		return true;
	} else {
		return false;
	}
}
	
//handle actor stuck between mover and solid
function squash() {
	
}

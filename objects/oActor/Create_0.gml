//INIT\\
xspd = 0;
xspd_remainder = 0;

yspd = 0;
yspd_remainder = 0;

dir = 1;

//MOVEMENT FUNCTIONS\\
function moveX(_xspd,collision_event = function() {}) {
	xspd_remainder += _xspd; //add the current frame's xspd to the last frame's remainder
	var _move = floor(xspd_remainder); //get whole number of pixels to move
	
	if (_move != 0) {
		xspd_remainder -= _move; //leave fractional remainder for next frame
		var _dir = sign(_move); //get the direction of movement
		
		//as long as there is movement left move one pixel in the direction
		//unless there is a solid in the way
		while (_move != 0) {
			
			////RIDERS THAT ARE ACTORS BUT DON'T COLLIDE WITH SOLIDS\\
			//if (self.object_index == oSpike) {
			//	x += _dir; //move one pixel in direction 
			//	_move -= _dir; //count down remaining movement pixels in frame	
			//}
			////RIDERS THAT DO COLLIDE WITH SOLIDS\\
			//else 
			if (!place_meeting(x+_dir,y,oSolid)) {
				x += _dir; //move one pixel in direction
				_move -= _dir; //count down remaining movement pixels in frame
			} else {
				//collision occurs
				collision_event();
				break;
			}	
		}
	}
}

function moveY(_yspd,collision_event = function() {}) {
	yspd_remainder += _yspd; //add the current frame's xspd to the last frame's remainder
	var _move = floor(yspd_remainder); //get whole number of pixels to move
	
	if (_move != 0) {
		yspd_remainder -= _move; //leave fractional amount for next frame
		var _dir = sign(_move); //get the direction of movement
		
		//as long as there is movement left move one pixel in the direction
		//unless there is a solid in the way
		while (_move != 0) {
			if (!place_meeting(x,y+_dir,oSolid)) {
				y += _dir; //move one pixel in direction
				_move -= _dir; //count down remaining movement pixels in frame
			} else {
				//collision occurs
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
	//on top
	if (place_meeting(x,y+1,solid)) return true;
	//underneath
	else if (place_meeting(x,y-1,solid) && sign(solid.yspd) == 1) return true;
	//moving the same direction horizontally
	else if (place_meeting(x+sign(solid.xspd),y,solid) && sign(xspd) == sign(solid.xspd)) return true;
	else return false;
}
	
//handle actor stuck between mover and solid
function squash() {
	
}

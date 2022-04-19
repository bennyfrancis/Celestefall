#region Initialize


	xspd = 0;
	xspd_remainder = 0;

	yspd = 0;
	yspd_remainder = 0;

	dir = 1;
	

#endregion
#region Utils


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
		if (place_meeting(x, y+1, solid)) { return true }; //on top
		if (place_meeting(x, y-1, solid) && sign(solid.yspd) == 1) { return true }; //underneath
		return (place_meeting(x+sign(solid.xspd), y, solid) && sign(xspd) == sign(solid.xspd)); //moving the same direction horizontally
	}
	
	//handle actor stuck between mover and solid
	function squash() {
	
	}
	

#endregion
#region Movement and collision


	function moveX(_xspd, _collision_event = function() { collideX(); }) {
		xspd_remainder += _xspd; //add the current frame's xspd to the last frame's remainder
		var _move = floor(xspd_remainder); //get whole number of pixels to move
	
		if (_move != 0) {
			xspd_remainder -= _move; //leave fractional remainder for next frame
			var _dir = sign(_move); //get the direction of movement
		
			while (_move != 0) {
				var collision_instance = instance_place(x+_dir, y, oSolid);
				if (collision_instance != noone) {
					_collision_event(collision_instance);
					break;
				}
			
				x += _dir;
				_move -= _dir;
			}
		}
	}

	function moveY(_yspd, _collision_event = function() { collideY(); }) {
		yspd_remainder += _yspd; //add the current frame's xspd to the last frame's remainder
		var _move = floor(yspd_remainder); //get whole number of pixels to move
	
		if (_move != 0) {
			yspd_remainder -= _move; //leave fractional amount for next frame
			var _dir = sign(_move); //get the direction of movement
		
			while (_move != 0) {
				var collision_instance = instance_place(x, y+_dir, oSolid);
				if (collision_instance != noone) {
					_collision_event(collision_instance);
					break;
				}
			
				y += _dir;
				_move -= _dir;
			}
		}
	}
	

#endregion


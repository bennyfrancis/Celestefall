#region Initialize
	
	//movement variables
	xspd = 0;
	xspd_remainder = 0;

	//do not change these!
	yspd = 0;
	yspd_remainder = 0;

#endregion

#region Utils

	//default action when actor collides with a solid (halt actor movement)
	function collide_x() {
		xspd = 0;
		xspd_remainder = 0;
	}

	function collide_y() {
		yspd = 0;
		yspd_remainder = 0;
	}
	
	//used by solid to detect if an actor is riding it
	//add additional returns here for more riding actions like clinging, wall sliding, etc.
	//Param: solid (instance of moving solid colliding with actor)
	//Returns: True or false
	function is_riding(_solid) {
		//optional check for player wall clinging
		if (clinging && cling_inst == _solid.id) { return true };
		
		// Don't change or remove these
		//actor is on top
		if (place_meeting(x, y+1, _solid)) { return true };
		//actor is underneath
		if (place_meeting(x, y-1, _solid) && sign(_solid.yspd) == 1) { return true };
		//actor is moving the same direction horizontally as a moving solid (moving faster than the solid)
		return (place_meeting(x+sign(_solid.xspd), y, _solid) && sign(xspd) == sign(_solid.xspd)); 
	}	
	
	//default action to execute when actor is squashed between two solids
	function squash() {

	}

#endregion

#region Movement and collision

	//pixel by pixel movement and collision checks, carrying fractional remainders to next frame
	//Param: _xspd,_yspd (amount to move actor in current frame)
	//Param: _collision_event (function to execute when a collision is detected (defaults to halting actor movement))
	function move_x(_xspd, _collision_event = function() { collide_x(); }) {
		xspd_remainder += _xspd;
		var _move = floor(xspd_remainder);
	
		if (_move != 0) {
			xspd_remainder -= _move;
			var _dir = sign(_move);
		
			while (_move != 0) {
				var collision_instance = instance_place(x+_dir, y, o_solid);
				if (collision_instance != noone) {
					_collision_event(collision_instance);
					break;
				}
			
				x += _dir;
				_move -= _dir;
			}
		}
	}

	function move_y(_yspd, _collision_event = function() { collide_y(); }) {
		yspd_remainder += _yspd;
		var _move = floor(yspd_remainder);
	
		if (_move != 0) {
			yspd_remainder -= _move;
			var _dir = sign(_move);
		
			while (_move != 0) {
				
				//collision with regular solids
				var collision_instance = instance_place(x, y+_dir, o_solid);
				if (collision_instance != noone) {
						_collision_event(collision_instance);
						break;
				}
				
				//collision with one way solids
				//performs a bbox check to see if actor is above solid
				var collision_instance = instance_place(x, y+_dir, o_solid_oneway);
				if (collision_instance != noone && bbox_bottom <= collision_instance.bbox_top) {
					//this speed check catches a bug with the player sticking to the platform when they shouldn't
					if (yspd > 0 || collision_instance.yspd < 0) {
						_collision_event(collision_instance);
						break;
					}
				}
			
				y += _dir;
				_move -= _dir;
			}
		}
	}

#endregion


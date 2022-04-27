#region Initialize

	list_of_riders = ds_list_create();
	
	//movement variables
	xspd = 0;
	xspd_remainder = 0;

	yspd = 0;
	yspd_remainder = 0;

	dir = 1; //movement direction
	
#endregion

#region Movement and collision

	//Note: movement for solids should normally be executed in the Begin Step event
	//pixel by pixel movement and collision checks, carrying fractional remainders to next frame
	//first try and push any actors (if an overlap between an actor and moving solid occurs, move actor to the appropriate leading edge)
	//then carry any riding actors
	//Param: _xspd,_yspd (amount to move solid in current frame)
	//Param: _collision_event (function to execute when a collision is detected (defaults to no action))
	function move_x(_xspd, _collision_event = function() {}) {
		xspd_remainder += _xspd;
		var _move = round(xspd_remainder);
	
		if (_move != 0) {		
			xspd_remainder -= _move;
			var _dir = sign(_move);
	
			rider_populate_list(list_of_riders);
		
			while (_move != 0) {
				
				// Check for collision in next spot
				var colliding_instance = instance_place(x+_dir, y, o_solid);
				if (colliding_instance != noone) {
					_collision_event(colliding_instance);
					break;
				}
				
				x += _dir;
					
				// Carry actors
				with (o_actor) {
					if (place_meeting(x, y, other)) {
						if (_move > 0) {
							// Carry while moving right
							move_x(other.bbox_right-bbox_left+_dir, squash);
						} else {
							// Carry while moving left
							move_x(other.bbox_left-bbox_right+_dir, squash);
						}
					} else if (ds_list_find_index(other.list_of_riders, id) != -1) {
						move_x(_dir);
					}
				}
				
				_move -= _dir;
			}
		}
	}
	
	function move_y(_yspd, _collision_event = function() {}) {
		yspd_remainder += _yspd;
		var _move = round(yspd_remainder);
	
		if (_move != 0) {		
			yspd_remainder -= _move;
			var _dir = sign(_move);
	
			rider_populate_list(list_of_riders);

			while (_move != 0) {
				
				// Check for collision in next spot
				var colliding_instance = instance_place(x, y+_dir, o_solid);
				if (colliding_instance != noone) {
					_collision_event(colliding_instance);
					break;
				}
				
				y += _dir;
					
				// Carry actors
				with (o_actor) {
					//we need to check if the solid is moving up faster than the actor
					//this catches a bug caused by jumping over/through a platform on the wrong frame
					var _diff = yspd - other.yspd;
					if (place_meeting(x, y, other)) {
						if (_move > 0) {
							// Carry while moving down
							move_y(other.bbox_bottom-bbox_top+_dir, squash);
						} else {
							// Carry while moving up
							if (_diff > 0) { move_y(other.bbox_top-bbox_bottom+_dir, squash); }
						}
					} else if (ds_list_find_index(other.list_of_riders, id) != -1) {
						if (_move > 0) { move_y(_dir); }
						if (_move < 0 && _diff > 0) { move_y(_dir); }
					}
				}
					
				_move -= _dir;
			}
		}
	}
		
#endregion

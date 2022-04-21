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
	function move_x(_xspd, collision_event = function() {}) {
		xspd_remainder += _xspd;
		var _move = xspd_remainder;
		var _move = round(xspd_remainder);
	
		if (_move != 0) {		
			xspd_remainder -= _move;
			var _dir = sign(_move);
	
			get_rider_list(list_of_riders);
		
			while (_move != 0) {
				if (!place_meeting(x+_dir, y, o_solid)) {
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
				} else {
					collision_event();
					break;
				}
			}
		}
	}
	
	function move_y(_yspd, collision_event = function() {}) {
		yspd_remainder += _yspd;
		var _move = yspd_remainder;
		var _move = round(yspd_remainder);
	
		if (_move != 0) {		
			yspd_remainder -= _move;
			var _dir = sign(_move);
	
			get_rider_list(list_of_riders);

			while (_move != 0) {
				if (!place_meeting(x, y+_dir, o_solid)) {
					y += _dir;
					
					// Carry actors
					with (o_actor) {
						if (place_meeting(x, y, other)) {
							if (_move > 0) {
								// Carry while moving down
								move_y(other.bbox_bottom-bbox_top+_dir, squash);
							} else {
								// Carry while moving up
								move_y(other.bbox_top-bbox_bottom+_dir, squash);
							}
						} else if (ds_list_find_index(other.list_of_riders, id) != -1) {
							move_y(_dir);
						}
					}
					
					_move -= _dir;
				
				} else {
					collision_event();
					break;
				}
			}
		}
	}
		
#endregion

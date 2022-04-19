#region Initialize
	
	//movement variables
	xspd = 0;
	xspd_remainder = 0;

	yspd = 0;
	yspd_remainder = 0;

	dir = 1; //movement direction
	
#endregion

#region Utils

	//populate a list of all actors who are riding the solid
	function get_rider_list() {
		var _list_of_riders = ds_list_create();
		ds_list_clear(_list_of_riders);

		with (oActor) {
			if (is_riding(other)) ds_list_add(_list_of_riders,id);
		}
	}

#endregion

#region Movement and collision

	//pixel by pixel movement and collision checks, carrying fractional remainders to next frame
	//Param: _xspd,_yspd (amount to move solid in current frame)
	//Param: _collision_event (function to execute when a collision is detected (defaults to no action))
	function move_x(_xspd, collision_event = function() {}) {
		xspd_remainder += _xspd;
		var _move = xspd_remainder;
		var _move = round(xspd_remainder);
	
		if (_move != 0) {		
			xspd_remainder -= _move;
			var _dir = sign(_move);
	
			get_rider_list();
		
			while (_move != 0) {
				if (!place_meeting(x+_dir,y,oSolid)) {
					//move the platform
					x += _dir;
				
					//pushing/carrying player while moving RIGHT
					if (_move > 0) {
					//check each actor to see if they are overlapping the solid
						with (oActor) {
							if (place_meeting(x,y,other)) {
								//move any actors overlapping to the appropriate leading edge based on movement direction
								//squash them if this will force them into a solid
								move_x(other.bbox_right-bbox_left+_dir,squash()); 
							} else if (ds_list_find_index(_list_of_riders,id) != -1) {
								move_x(_dir); //carry the actor if they are riding the solid
							}
						}
					
					//pushing/carrying player while moving LEFT
					} else {
					//check each actor to see if they are overlapping the solid
						with (oActor) {
							if (place_meeting(x,y,other)) {
								//move any actors overlapping to the appropriate leading edge based on movement direction
								move_x(other.bbox_left-bbox_right+_dir,squash());
							} else if (ds_list_find_index(_list_of_riders,id) != -1) {
								move_x(_dir); //carry the actor if they are riding the solid
							}
						}
					}
				
					_move -= _dir; //count down remaining movement pixels in frame
				} else {
					//what happens on collision with a solid
					collision_event();
					ds_list_destroy(_list_of_riders); //list clean up
					break;
				}
			}
			ds_list_destroy(_list_of_riders); //list cleanup
		}
	}
	
	function move_y(_yspd, collision_event = function() {}) {
		yspd_remainder += _yspd; //add the current frame's xspd to the last frame's remainder
		var _move = yspd_remainder;
		var _move = round(yspd_remainder); //get whole number of pixels to move
	
		if (_move != 0) {		
			yspd_remainder -= _move; //leave fractional remainder for next frame
			var _dir = sign(_move); //get the direction of movement
	
			////get a list of actors who are riding the solid before moving either
			var _list_of_riders = ds_list_create();
			ds_list_clear(_list_of_riders);
							
			with (oActor) {
				if (is_riding(other)) ds_list_add(_list_of_riders,id);
			}
					
			//as long as there is movement left move one pixel in the direction
			//unless there is a solid in the way
			while (_move != 0) {
				if (!place_meeting(x,y+_dir,oSolid)) {
					y += _dir; //move one pixel in direction
				
					//pushing/carrying player while moving DOWN
					if (_move > 0) {		
						//check each actor to see if they are overlapping the solid
						with (oActor) {
							if (place_meeting(x,y,other)) {
								//move any actors overlapping to the appropriate leading edge based on movement direction
								move_y(other.bbox_bottom-bbox_top+_dir,squash());
							} else if (ds_list_find_index(_list_of_riders,id) != -1) {
								//carry the actor if they are riding the solid
								move_y(_dir);
							}
						}	
					//pushing/carrying player while moving UP
					} else {
					//check each actor to see if they are overlapping the solid
						with (oActor) {
							if (place_meeting(x,y,other)) {
								//move any actors overlapping to the appropriate leading edge based on movement direction
								move_y(other.bbox_top-bbox_bottom+_dir,squash());
							} else if (ds_list_find_index(_list_of_riders,id) != -1) {
								//carry the actor if they are riding the solid
								move_y(_dir);
							}
						}
					} 
					_move -= _dir; //count down remaining movement pixels in frame
				
				} else {
					collision_event();
					ds_list_destroy(_list_of_riders); //list clean up
					break;
				}
			}
			ds_list_destroy(_list_of_riders); //list cleanup
		}
	}
		
#endregion

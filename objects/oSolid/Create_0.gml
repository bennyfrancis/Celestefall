//INIT\\
xspd = 0;
xspd_remainder = 0;

yspd = 0;
yspd_remainder = 0;

dir = 1;

function moveX(_xspd,collision_event = function() {}) {
	xspd_remainder += _xspd; //add the current frame's xspd to the last frame's remainder
	var _move = xspd_remainder;
	var _move = round(xspd_remainder); //get whole number of pixels to move
	
	if (_move != 0) {		
		xspd_remainder -= _move; //leave fractional remainder for next frame
		var _dir = sign(_move); //get the direction of movement
	
		//get a list of actors who are riding the solid before moving either
		var _list_of_riders = ds_list_create();
		ds_list_clear(_list_of_riders);

		with (oActor) {
			if (is_riding(other)) ds_list_add(_list_of_riders,id);
		}
		
		//as long as there is movement left move one pixel in the direction unless there is a solid in the way
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
							moveX(other.bbox_right-bbox_left+_dir,squash()); 
						} else if (ds_list_find_index(_list_of_riders,id) != -1) {
							moveX(_dir); //carry the actor if they are riding the solid
						}
					}
					
				//pushing/carrying player while moving LEFT
				} else {
				//check each actor to see if they are overlapping the solid
					with (oActor) {
						if (place_meeting(x,y,other)) {
							//move any actors overlapping to the appropriate leading edge based on movement direction
							moveX(other.bbox_left-bbox_right+_dir,squash());
						} else if (ds_list_find_index(_list_of_riders,id) != -1) {
							moveX(_dir); //carry the actor if they are riding the solid
						}
					}
				}
				
				_move -= _dir; //count down remaining movement pixels in frame
			} else {
				//what happens on collision with a solid
				collision_event();;
				ds_list_destroy(_list_of_riders); //list clean up
				break;
			}
		}
		ds_list_destroy(_list_of_riders); //list cleanup
	}
}
	
function moveY(_yspd,collision_event = function() {}) {
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
							moveY(other.bbox_bottom-bbox_top+_dir,squash());
						} else if (ds_list_find_index(_list_of_riders,id) != -1) {
							//carry the actor if they are riding the solid
							moveY(_dir);
						}
					}	
				//pushing/carrying player while moving UP
				} else {
				//check each actor to see if they are overlapping the solid
					with (oActor) {
						if (place_meeting(x,y,other)) {
							//move any actors overlapping to the appropriate leading edge based on movement direction
							moveY(other.bbox_top-bbox_bottom+_dir,squash());
						} else if (ds_list_find_index(_list_of_riders,id) != -1) {
							//carry the actor if they are riding the solid
							moveY(_dir);
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

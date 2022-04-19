//INIT\\
xspd = 0;
xspd_remainder = 0;

yspd = 0;
yspd_remainder = 0;

dir = 1;

function moveX(_xspd,collision_event = function() {}) {
	xspd_remainder += _xspd;
	var _move = xspd_remainder;
	var _move = round(xspd_remainder);
	
	if (_move != 0) {		
		xspd_remainder -= _move;
		var _dir = sign(_move);
	
		//get a list of actors who are riding the solid
		var _list_of_riders = ds_list_create();
		ds_list_clear(_list_of_riders);

		with (oActor) {
			if (is_riding(other)) ds_list_add(_list_of_riders,id);
		}
		
		while (_move != 0) {
			if (!place_meeting(x+_dir,y,oSolid)) {
				x += _dir;	
				
				//pushing/carrying player while moving RIGHT
				if (_move > 0) {
					with (oActor) {
						if (place_meeting(x,y,other)) {
							//move any actors overlapping to the appropriate leading edge based on movement direction
							//or handle being squashed between mover and solid
							moveX(other.bbox_right-bbox_left+_dir,squash());
						} else if (ds_list_find_index(_list_of_riders,id) != -1) {
							moveX(_dir); //carry the actor if they are riding the solid
						}
					}
					
				//pushing/carrying player while moving LEFT
				} else {
					with (oActor) {
						if (place_meeting(x,y,other)) {
							//move any actors overlapping to the appropriate leading edge based on movement direction
							//or handle being squashed between mover and solid
							moveX(other.bbox_left-bbox_right+_dir,squash());
						} else if (ds_list_find_index(_list_of_riders,id) != -1) {
							moveX(_dir); //carry the actor if they are riding the solid
						}
					}
				}
				
				_move -= _dir;
			} else {
				collision_event();;
				ds_list_destroy(_list_of_riders);
				break;
			}
		}
		ds_list_destroy(_list_of_riders);
	}
}
	
function moveY(_yspd,collision_event = function() {}) {
	yspd_remainder += _yspd;
	var _move = yspd_remainder;
	var _move = round(yspd_remainder);
	
	if (_move != 0) {		
		yspd_remainder -= _move;
		var _dir = sign(_move);
	
		var _list_of_riders = ds_list_create();
		ds_list_clear(_list_of_riders);
							
		with (oActor) {
			if (is_riding(other)) ds_list_add(_list_of_riders,id);
		}
					

		while (_move != 0) {
			if (!place_meeting(x,y+_dir,oSolid)) {
				y += _dir;
				
				if (_move > 0) {	
					with (oActor) {
						if (place_meeting(x,y,other)) {
							//move any actors overlapping to the appropriate leading edge based on movement direction
							//or handle being squashed between mover and solid
							moveY(other.bbox_bottom-bbox_top+_dir,squash());
						} else if (ds_list_find_index(_list_of_riders,id) != -1) {
							moveY(_dir); //carry the actor if they are riding the solid
						}
					}	
				//pushing/carrying player while moving UP
				} else {
					with (oActor) {
						if (place_meeting(x,y,other)) {
							//move any actors overlapping to the appropriate leading edge based on movement direction
							//or handle being squashed between mover and solid
							moveY(other.bbox_top-bbox_bottom+_dir,squash());
						} else if (ds_list_find_index(_list_of_riders,id) != -1) {
							moveY(_dir); //carry the actor if they are riding the solid
						}
					}
				} 
				_move -= _dir;
				
			} else {
				collision_event();
				ds_list_destroy(_list_of_riders);
				break;
			}
		}
		ds_list_destroy(_list_of_riders);
	}
}

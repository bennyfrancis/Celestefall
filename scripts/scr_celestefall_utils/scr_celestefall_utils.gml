function on_solid() {
	return (place_meeting(x, y+1, o_solid) || place_meeting(x, y+1, o_solid_oneway));
}

// Populate a referenced list of all actors who are riding the solid
// Returns: void
function rider_populate_list(_list_of_riders) {
	ds_list_clear(_list_of_riders);

	with (o_actor) {
		if (is_riding(other)) ds_list_add(_list_of_riders, id);
	}
}

function move_x(_xspd, actor_func = undefined, _collision_event = function() {}) {
	xspd_remainder += _xspd;
	var _move = round(xspd_remainder);
	
	if (_move != 0) {		
		xspd_remainder -= _move;
		var _dir = sign(_move);
		
		if (actor_func) {
			rider_populate_list(list_of_riders);
		}
		
		while (_move != 0) {
				
			// Check for collision in next spot
			var colliding_instance = instance_place(x+_dir, y, o_solid);
			if (colliding_instance != noone) {
				_collision_event(colliding_instance);
				break;
			}
				
			x += _dir;
	
			if (actor_func) {
			    with(o_actor) {
			        actor_func();
			    }
			}
	
			_move -= _dir;
		}
	}
}


function move_y(_yspd, actor_func = undefined, _collision_event = function() {}) {
	yspd_remainder += _yspd;
	var _move = round(yspd_remainder);
	
	if (_move != 0) {		
		yspd_remainder -= _move;
		var _dir = sign(_move);
		
		if (actor_func) {
			rider_populate_list(list_of_riders);
		}
		
		while (_move != 0) {
				
			// Check for collision in next spot
			var colliding_instance = instance_place(x, y+_dir, o_solid);
			if (colliding_instance != noone) {
				_collision_event(colliding_instance);
				break;
			}
				
			y += _dir;
	
			if (actor_func) {
			    with(o_actor) {
			        actor_func();
			    }
			}
	
			_move -= _dir;
		}
	}
}

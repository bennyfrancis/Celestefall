//Check if actor is standing on a solid
//Returns: True or False

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

//Move the object and run collision using the parent object's own move_x() and move_y() functions
//Param: _xspd,_yspd (amount to move object in current frame)
//Param: _collision_event (function to execute when a collision is detected
function move_and_collide(_xspd,_yspd,_collision_event_x,_collision_event_y) {
	move_x(_xspd,_collision_event_x);
	move_y(_yspd,_collision_event_y);
}

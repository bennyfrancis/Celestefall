//Check if actor is standing on a solid
//Returns: boolean

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


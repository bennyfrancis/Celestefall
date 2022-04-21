// Inherit the parent event
event_inherited();

grav		= 0.5;
jumpspd		= -8;
maxfallspd	= 6;


function squash() {
	show_debug_message("squashed");
	instance_create_depth(x, y, -1, o_player_squash);
	instance_destroy(id);
}

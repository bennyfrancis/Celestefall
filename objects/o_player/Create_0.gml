// Inherit the parent event
event_inherited();

grav		= 0.5;
jumpspd		= -8;
maxfallspd	= 6;
clinging	= false;
cling_inst	= noone;
cling_dir	= 0;

function squash() {
	instance_create_depth(x, y, -1, o_player_squash);
	instance_destroy(id);
}

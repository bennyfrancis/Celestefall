// Inherit the parent event
event_inherited();

grav		= 0.5;
jumpspd		= -10;
maxfallspd	= 6;


function on_ground() {
	return (place_meeting(x, y+1, oSolid));
}

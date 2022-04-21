draw_set_font(f_demo);
draw_set_halign(fa_left);
draw_set_valign(fa_bottom);

var _spacer = 20,
	_x = 0+5,
	_y = display_get_gui_height()-5;

if (tooltips_on) {
	draw_text_outline(_x,_y,"Hide Tooltips: Tab",c_white,c_black,1);
	_y -= _spacer;
	draw_text_outline(_x,_y,"Drop Through: S / Down Arrow",c_white,c_black,1);
	_y -= _spacer;
	draw_text_outline(_x,_y,"Jump: W / Space / Up Arrow",c_white,c_black,1);
	_y -= _spacer;
	draw_text_outline(_x,_y,"Move: A, D / Left Arrow, Right Arrow",c_white,c_black,1);
} else {
	draw_text_outline(_x,_y,"Show Tooltips: Tab",c_white,c_black,1);
}

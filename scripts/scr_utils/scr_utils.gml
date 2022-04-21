/// @func draw_text_outline(x, y, string, text_col, outline_col, thickness)
function draw_text_outline(_x, _y, _string, _textCol, _outCol, _thickness) {
	var _xx, _yy;
	for (_xx = _x-_thickness; _xx <= _x+_thickness; ++_xx) {
		for (_yy = _y-_thickness; _yy <= _y+_thickness; ++_yy) {
			draw_text_color(_xx, _yy, _string, _outCol, _outCol, _outCol, _outCol, 1);
		}
	}
	draw_text_color(_x, _y, _string, _textCol, _textCol, _textCol, _textCol, 1);
}

/// @func animation_end()
function animation_end() {
	return (image_index + image_speed*sprite_get_speed(sprite_index)/(sprite_get_speed_type(sprite_index)==spritespeed_framespergameframe? 1 : game_get_speed(gamespeed_fps)) >= image_number);	
}

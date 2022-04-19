if (instance_exists(follow)) {	
	
	var _xTo = clamp(follow.x-view_width/2,0,room_width-view_width),
		_yTo = clamp(follow.y-view_height/2,0,room_height-view_height);	
	
	var _curX = camera_get_view_x(view),
		_curY = camera_get_view_y(view),
		_movespd = 0.12;
	
	if (point_distance(_curX,_curY,_xTo,_yTo) >= 1) {
	
		//move camera to new object position
		_curX = lerp(_curX,_xTo,_movespd);
		_curY = lerp(_curY,_yTo,_movespd);
	
		_curX = (round(_curX*ratio)) / ratio;
		_curY = (round(_curY*ratio)) / ratio;
		
	}
	
	camera_set_view_pos(view,_curX,_curY);
}

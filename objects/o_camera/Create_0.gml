view = view_camera[0];
camera_set_view_size(view,640,360);

surface_resize(application_surface,1920,1080);
view_width = camera_get_view_width(view);
view_height = camera_get_view_height(view);

display_set_gui_size(view_width*2,view_height*2);
window_set_size(view_width*2,view_height*2);

follow = o_player;

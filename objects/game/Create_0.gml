/// @description 

debug = false;
gui_vars = true;
pause_time = true;
pause_game = false;

gui_inventory = true;

gui_width = display_get_gui_width();
gui_height = display_get_gui_height();

black_alpha = 0;

spawn_room = -1;
spawn_x = 0;
spawn_y = 0;
spawn_player_facing = -1;

do_transition = false;

room_scale = view_wport[0] / camera_get_view_width(view_camera[0]);

// Directions - based on 'direction' and unit circle
enum dir {
	right = 0,
	up	  = 90,
	left  = 180,
	down  = 270,
}

// Comment this out if want to have repeatable-testing
randomize();

room_goto_next();


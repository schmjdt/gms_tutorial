/// @description movement

// INPUT -> INTENDED MOVEMENT -> (FUTURE) COLLISION CHECK -> APPLY MOVEMENT

// --- UPDATE INPUT
input_left	= keyboard_check(vk_left);
input_right = keyboard_check(vk_right);
input_up	= keyboard_check(vk_up);
input_down	= keyboard_check(vk_down);
input_slow  = keyboard_check(vk_control);
input_fast  = keyboard_check(vk_shift);

// --- ALTER SPEED
if (input_slow or input_fast) {
	spd = abs((input_slow * spd_slow) - (input_fast * spd_fast));
} else {
	spd = spd_norm;	
}

// --- RESET MOVE VARIABLES
moveX = 0;
moveY = 0;

// --- INTENDED MOVEMENT
moveX = (input_right - input_left) * spd;
// Remove diagonol movement
if (moveX == 0) {
	// Biased towards left/right
	moveY = (input_down - input_up) * spd;
}

// --- GET FACING
if (moveX != 0) {
	switch(sign(moveX)) {
		case 1: facing = dir.right; break;
		case -1: facing = dir.left; break;
	}
} else if (moveY != 0) {
	switch(sign(moveY)) {
		case 1: facing = dir.down; break;
		case -1: facing = dir.up; break;
	}
} else {
	facing = -1;
}

// --- COLLISION CHECK
// -   HORIZONTAL
if (moveX != 0) {
	var collisionH = instance_place(x + moveX, y, obj_collision);
	if (collisionH != noone and collisionH.collidable) {
		repeat(abs(moveX)) {
			if (!place_meeting(x + sign(moveX), y, obj_collision)) {
				x += sign(moveX);
			} else {
				break;
			}
		}
		// Since manually moved above, set speed to 0
		moveX = 0;	
	}
}

// -   VERTICAL
if (moveY != 0) {
	var collisionV = instance_place(x, y + moveY, obj_collision);
	if (collisionV != noone and collisionV.collidable) {
		repeat(abs(moveY)) {
			if (!place_meeting(x, y + sign(moveY), obj_collision)) {
				y += sign(moveY);
			} else {
				break;
			}
		}
		// Since manually moved above, set speed to 0
		moveY = 0;	
	}
}

// -    OBJECTS
var inst = instance_place(x, y, obj_transition);
if (inst != noone and facing == inst.player_facing_before) {
	with (game) {
		if (! do_transition) {
			spawn_room = inst.target_room;
			spawn_x = inst.target_x;
			spawn_y = inst.target_y;
			spawn_player_facing = inst.player_facing_after;
			do_transition = true;
		}
	}
}

// --- APPLY MOVEMENT
x += moveX;
y += moveY;

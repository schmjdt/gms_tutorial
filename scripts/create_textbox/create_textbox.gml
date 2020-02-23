/// @desc create_textbox
/// @arg text
/// @arg speakers

var _inst = instance_create_layer(0, 0, "Text", obj_textbox);

with (_inst) {
	text = argument[0];
	speakers = argument[1];
	
	var _len = array_length_1d(text);
	
	var i = 0;
	repeat (_len) {
		names[i]	 = speakers[i].name;
		voices[i]	 = speakers[i].voice;
		portraits[i] = speakers[i].portrait_index;
				
		i += 1;
	}
	
	event_perform(ev_other, ev_user1);
}

return _inst;
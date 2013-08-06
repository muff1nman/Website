/*
* main.js
* Copyright (C) 2013 Andrew DeMaria (muff1nman) <ademaria@mines.edu>
*
* All Rights Reserved.
*/

var code_id_attribute = "data-code-id";
var code_hidden_attribute = "data-hidden";

var generate_Coderay_button_html = function(id) {
	return "<button class='CodeRayNumberToggle' " + code_id_attribute + "='" + id + "'>Toggle Line Numbers</button>";
};

var add_toggle_code_btns = function() {
	$( ".CodeRay" ).each( function(index, code_ray_div) {
		$(this).attr(code_id_attribute, index);
		$(this).parent().before( generate_Coderay_button_html(index));
	});
};

var connect_code_toggles = function() {
	$( ".CodeRayNumberToggle" ).click( function() {
		var code = $("[" + code_id_attribute + "='" + $(this).attr( code_id_attribute ) + "']");
		var hidden = code.attr(code_hidden_attribute);
		if (!hidden || hidden == "false") {
			code.find('.line-numbers').hide();
			code.attr(code_hidden_attribute, true);
		} else {
			code.find('.line-numbers').show();
			code.attr(code_hidden_attribute, false);
		}
	});
};


$( document ).ready( function() {
	add_toggle_code_btns();
	connect_code_toggles();
});

// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require turbolinks
//= require_tree .

$(document).ready(function(){
	$('#add_recipient').on('click', function(event){
		event.preventDefault();
		var $container = $("#add_recipient_form");

		var action = "/users/1/recipients/new";

		var request = $.ajax({
			url: action, 
			type: "GET"
		});

		request.done(function(response){
			($container).html(response);
		});
	});

	$('#add_recipient_form').on('click', 'input[type="submit"]', function(event){
		event.preventDefault();
		var button = $(this);
		var form = button.parent();
		var data = form.serialize();
		var email = form.find('input#recipient_email').val();
		var name = form.find('input#recipient_name').val();
		
		var action = "/users/1/recipients";

		var request = $.ajax({
			url: action, 
			type: "POST", 
			data: {"recipient[email]": email, "recipient[name]": name}
		});

		request.done(function(){

		});


	});
});





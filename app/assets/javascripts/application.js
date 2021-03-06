// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require jquery.tokeninput
// Loads all Bootstrap javascripts
//= require bootstrap
//= require gmaps4rails/gmaps4rails.base.js.coffee
//= require gmaps4rails/gmaps4rails.googlemaps.js.coffee
//= require_tree .
$(document).ready(function() {
	$('.lang_tokens').tokenInput("/programming_languages.json", {
		theme: "facebook",
		propertyToSearch: "language",
		preventDuplicates: true,
		prePopulate: $('.lang_tokens').data('load')
	});
	
	$('#event_event_date').datepicker({
		dateFormat: "dd-mm-yy"
	});

	$('#event_country_select').change(function(){
		if ($(this).val() == 240){
			$('#event_state_id').val(52)
			$('#event_state_id').attr("disabled", "disabled");
		}else
              $("#event_state_id").removeAttr("disabled");
	});
});

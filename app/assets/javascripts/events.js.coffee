# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
	if $('.pagination').length
		$(window).scroll ->
			url = $('.pagination .next_page a').attr('href')
			console.log($('.pagination'))
			if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
				$('.pagination').html('<img src="/assets/ajax-loader.gif" />')
				$.getScript(url)
		$(window).scroll()
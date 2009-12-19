// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

document.observe('dom:loaded', function() {	
	/* Hide the "Event created/updated/deleted" message when clicking on ajax links */
	$$("a.ajax").each(function(el) {
		$(el).observe('click', function() {
			$$("div.notice")[0].hide();
		});
	});
});

/* Put click event handlers for ajaxed elements here (the events get bubbled up) */
document.observe('click', function(ev) {
	if (ev.findElement().identify() == 'event_all_day') {
		$('event_start_time').toggle();
		$('event_end_time').toggle();
	}
});


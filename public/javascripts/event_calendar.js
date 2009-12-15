
document.observe('dom:loaded', function() {
	/* Event highlighting (goes across rows) */
	$$("div[event_id].ec-event").each(function(el) {
		$(el).observe('mouseover', function() {
			$$("div[event_id='"+$(this).readAttribute("event_id")+"'].ec-event").each (function(el2) {
				el2.setStyle({ backgroundColor: "#2EAC6A" });
			});
		});
		$(el).observe('mouseout', function() {
			$$("div[event_id='"+$(this).readAttribute("event_id")+"'].ec-event").each (function(el2) {
				el2.setStyle({ backgroundColor: "#9aa4ad" });
			});
		});
	});
	
	/* "Add Event" link is normally hidden, but unhide on mouseover day header */
	$$("td.ec-day-header").each(function(el) {
		$(el).observe('mouseover', function() {
			el.select("a.ec-day-add-event")[0].show();
		});
		$(el).observe('mouseout', function() {
			el.select("a.ec-day-add-event")[0].hide();
		});
	});
});

function register_handlers() {
	$$(".ajax").each(function(el) {
		$(el).observe('click', function() {
			$$("div.notice")[0].hide();
		});
	});
}

function ajax_load_url(url) {
	new Ajax.Updater('side', url, {
		method: 'get',
		onComplete: function() {
			register_handlers();
		}
	});
}

function ajax_month_index(url_prefix) {
	var year = $("side").readAttribute("year");
	var month = $("side").readAttribute("month");
	ajax_load_url(url_prefix + '/' + year + '/' + month)
}

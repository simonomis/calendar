/* event_calendar specific javascript */

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

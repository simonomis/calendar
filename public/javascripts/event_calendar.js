/* event_calendar specific javascript */

document.observe('dom:loaded', function() {
	/* Event highlighting (goes across rows) */
	$$("div[data-event-id].ec-event-bg").each(function(el) {
		$(el).observe('mouseover', function() {
			$$("div[data-event-id='"+$(this).readAttribute("data-event-id")+"'].ec-event-bg").each (function(el2) {
				el2.setStyle({ backgroundColor: highlight(el2.readAttribute("data-color")) });
			});
		});
		$(el).observe('mouseout', function() {
			$$("div[data-event-id='"+$(this).readAttribute("data-event-id")+"'].ec-event-bg").each (function(el2) {
				el2.setStyle({ backgroundColor: el2.readAttribute("data-color") });
			});
		});
	});
	$$("div.ec-event-no-bg").each(function(el) {
		$(el).observe('mouseover', function() {
			el.setStyle({ color: highlight(el.readAttribute("data-color")) });
		});
		$(el).observe('mouseout', function() {
			el.setStyle({ color: el.readAttribute("data-color") });
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

function highlight(color) {
	if (color.charAt(0) == '#' && color.length == 7) {
		/* it's a hex color string (i.e. '#rrggbb') so increase each color by 10% */
		var r = parseInt(parseInt(color.substring(1,3), 16) * 1.1);
		var g = parseInt(parseInt(color.substring(3,5), 16) * 1.1);
		var b = parseInt(parseInt(color.substring(5,7), 16) * 1.1);
		var str = "#" + ((Math.min(r,255) * 65536) + (Math.min(g,255) * 256) + Math.min(b,255)).toString(16);
		return str;
	}
	
	/* if we got this far we don't know what it is so just go green */
	return "#2EAC6A";
}
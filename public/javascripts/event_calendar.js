/* jQuery */
$(document).ready(function() {
  ajax_load_url("/month/" + $("#side").attr("year") + "/" + $("#side").attr("month"));
  $("div[event_id].ec-event").mouseover(function() {
    $("div[event_id='"+$(this).attr("event_id")+"'].ec-event").css("background-color", "#2EAC6A");
  });
  $("div[event_id].ec-event").mouseout(function() {
    $("div[event_id='"+$(this).attr("event_id")+"'].ec-event").css("background-color", "#9aa4ad");
  });
  $("td.ec-day-header").mouseover(function() {
	$("a.ec-day-add-event", this).css("visibility", "visible");
  });
  $("td.ec-day-header").mouseout(function() {
	$("a.ec-day-add-event", this).css("visibility", "hidden");
  });
  $("a.ec-day-add-event").click(function() {
	ajax_load_url("/events/new?day=" + $(this).attr("day") + "&month=" + $("#side").attr("month") + "&year=" + $("#side").attr("year"))
  });
})

function register_handlers() {
  $("#back").click(function() {
	ajax_load_url("/month/" + $("#side").attr("year") + "/" + $("#side").attr("month"))
  });
  $("#edit").click(function() {
	ajax_load_url("/events/" + $(this).attr("event") + "/edit")
  });
  $("div[event_id]").click(function() {
	ajax_load_url("/events/" + $(this).attr("event_id"))
  });
  $(".ajax").click(function() {
	$(".notice").css("visibility", "hidden")
  });
}

function ajax_load_url(url) {
  $("#side").load(url,register_handlers);
}

/* Select an entire event, for when it spans multiple rows */
/*
function select_event(ele, selected) {
  ele = $(ele);
  event_id = ele.readAttribute("event_id");
  events = $$('.event_'+event_id);
  events.each(function(event) {
    if (selected) event.setStyle({ backgroundColor: '#2EAC6A' });
    else event.setStyle({ backgroundColor: ele.readAttribute("color") });
  });
}
*/
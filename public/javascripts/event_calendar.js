/* jQuery */
$(document).ready(function() {
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
  /*$("a.ec-day-add-event").click(function() {
	ajax_load_url("/events/new?day=" + $(this).attr("day") + "&month=" + $("#side").attr("month") + "&year=" + $("#side").attr("year"))
  });*/
})

function register_handlers() {
  /*$("div[event_id]").click(function() {
	ajax_load_url("/events/" + $(this).attr("event_id"))
  });*/
  $(".ajax").click(function() {
	$(".notice").css("visibility", "hidden")
  });
}

function ajax_load_url(url) {
  $("#side").load(url,register_handlers);
}

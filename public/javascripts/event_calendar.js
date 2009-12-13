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
})

function register_handlers() {
  $(".ajax").click(function() {
	$(".notice").css("visibility", "hidden")
  });
}

function ajax_load_url(url) {
  $("#side").load(url,register_handlers);
}

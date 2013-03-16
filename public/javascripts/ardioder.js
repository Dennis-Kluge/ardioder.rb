$(function() {

	$('#on').click(function() {
		$.post("/light/on");
	});

	$('#off').click(function() {
		$.post("/light/off");
	});		

	$('#random').click(function() {
		$.post("/light/random");
	});		

	$(".on").click(function () {
		id = $(this).closest("span").attr("data-light");
		$.post("/light/" + id + "/on");
	});

	$(".off").click(function () {
		id = $(this).closest("span").attr("data-light");
		$.post("/light/" + id + "/off");
	});


	$( ".color" ).slider({
    orientation: "horizontal",
    range: "min",
    min: 0,
    max: 255,
    step: 1,
    value: 127,
    change: refreshSwatch
   });

	function refreshSwatch() {
		console.log(this)
		var id    = $(this).closest("span").attr("data-light");
		var red   = $(this).closest("span").find(".red").slider("value");
		var green = $(this).closest("span").find(".green").slider("value");
		var blue  = $(this).closest("span").find(".blue").slider("value");
    var data = 'data={ "r": ' + red + ', "g": ' + green + ', "b": ' + blue + ' }'
    console.log(data);
    $.post("/light/" + id + "/color", data).done(function(data){
    	console.log("data" + data);
    });
  }
})
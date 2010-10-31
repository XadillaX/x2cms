$(document).ready(function(){
	$(".accordion h3").click(function(){
		$(this).next("ul").slideToggle("slow")
		.siblings("p:visible").slideUp("slow");
		$(this).toggleClass("active");
	});
});
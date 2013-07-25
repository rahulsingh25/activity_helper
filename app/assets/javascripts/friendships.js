$(document).ready(function(){
	$(document).find('#friend-list').css("display","none");
	$(document).find('#friended-by-list').css("display","none");
	$(document).find('.inbox-message-list').css("display","none");
	$(document).find('.outbox-message-list').css("display","none");
	$(document).on("click", ".friend-link", function(){
		$(document).find('#friend-list').toggle("#friend-list");
	});

	$(document).on("click", ".friended-by-link", function(){
		$(document).find('#friended-by-list').toggle("#friended-by-list");
	});

	$(document).on("click",".see-inbox", function(){
		$(document).find('.inbox-message-list').toggle(".inbox-message-list");
	});

	$(document).on("click",".see-outbox", function(){
		$(document).find('.outbox-message-list').toggle(".outbox-message-list");
	});
});


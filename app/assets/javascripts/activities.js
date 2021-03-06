$(document).ready(function(){
	$(document).on("ajax:success","#create-activity-form",function(evt,data,status,xhr){
		$('#all-activities').find('.activities').prepend(xhr.responseText);
		
		var el = $('#create-activity-form');
		el.find('input:text,textarea').val('');
		el.find('.custom-select option').prop('selected',false);
	});

	$(document).on("ajax:error","#create-activity-form",function(evt, rahul, status, error){
		$(document).find('#new-activity-form').replaceWith(rahul.responseText);
	});

	$(document).on("click", ".comment-link", function(){
		$(this).closest('.activity-feed').find('.comment-form').toggle(".comment-form");
	});
});
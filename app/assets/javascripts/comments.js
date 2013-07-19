$(document).ready(function(){
	
	// $('.comment-form').css("display","none");	

	$(document).on("ajax:success",".create-comment-form",function(evt,data,status,xhr){
		$(this).closest('.user-comments').prepend(xhr.responseText);

		var clr = $(this);
		clr.find('input:text').val('');
	});

	$(document).on("ajax:error",".create-comment-form",function(evt, xhr, status, error){
		//alert(xhr.responseText);
		//$(this).closest('.comment-form').replaceWith(xhr.responseText);
		//$(this).closest('.comment-form').css("display","block");
	});
});

	
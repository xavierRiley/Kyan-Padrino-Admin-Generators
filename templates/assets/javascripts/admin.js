$('document').ready(function() {
  $.validator.setDefaults({
   errorClass: "error-js"
  })
  //hack to tidy up admin
  if($('td.fixed.last').html()) {
	$('td.fixed.last').each(function(index) {
		curHtml = $(this).html();
		$(this).html(curHtml.replace('|', ''));
		});
	}
});

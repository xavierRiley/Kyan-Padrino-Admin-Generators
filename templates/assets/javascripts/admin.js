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

  $("#filter").keyup(function () {
    var filter = $(this).val(), count = 0;
    $(".filtered:first tr").each(function () {
        if ($(this).text().search(new RegExp(filter, "i")) < 0) {
            $(this).addClass("hidden");
        } else {
            $(this).removeClass("hidden");
            count++;
        }
    });
    $("#filter-count").text(count);
  });
});

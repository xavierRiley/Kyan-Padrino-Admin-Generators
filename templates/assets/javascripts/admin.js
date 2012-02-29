$('document').ready(function() {
$(".collapse").collapse()
  //hack to tidy up admin
  if($('td.last').html()) {
	$('td.last').each(function(index) {
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

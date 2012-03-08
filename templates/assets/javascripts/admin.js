$('document').ready(function() {
  $(".collapse").collapse()
    //hack to tidy up admin
    if($('td.last').html()) {
    $('td.last').each(function(index) {
      var curHtml = $(this).html();
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

  $(document).on('click','[data-toggle]',function(e) {
    e.preventDefault();
    var href = window.location.protocol + '//' + window.location.host + '/' + $(this).attr('href');
    var hide_selector = $(this).attr('data-exclude');

    //see if modal already exists
    if ($('.modal').length > 0) {
      var modal_container = $('<div class="modal fade" />');
    } else {
      var modal_container = $('.modal');
    }

    var submitAction = function(){

    }
    //build the contents of the modal
    var modal_header = $('<div class="modal-header"><a class="close" data-dismiss="modal">x</a> <h3>Edit image</h3></div>');
    var modal_body = $('<div class="modal-body" />');
    var modal_footer = $('<div class="modal-footer"><a href="#" class="btn btn-success">Save</a> <a href="#" class="btn" data-dismiss="modal">Close</a></div>');
    var iframe = $('<iframe src="' + href + '" id="modal-iframe" frameborder="0" height="300" width="400" />').on('load', function() {
      if (iframe.contents().find('.message.notice').length > 0) {
          modal_container.on('hidden', function() {
            $('fieldset.thumbnail_gallery').load(window.location.href + ' .thumbnail_gallery');
          });
          modal_container.modal('hide');
      } else {
        var tempContent = iframe.contents().find('#content_wrap .content').clone();
        iframe.contents().find('body').empty().append(tempContent)
          .on('submit','form',submitAction)
          .find(hide_selector).hide();
      }
    }).appendTo(modal_body);

    //build the modal container
    modal_container = modal_container.empty().append(modal_header).append(modal_body).append(modal_footer).appendTo('body');
    $('body').append(modal_container);

    modal_container.modal({ show: false});

    modal_container.on('click', '.btn-success', function(e) {
      e.preventDefault();
      iframe.contents().find('.form_send .submit').eq(0).trigger('click');
    });

    modal_container.modal('show');
  });

  $().alert();
});

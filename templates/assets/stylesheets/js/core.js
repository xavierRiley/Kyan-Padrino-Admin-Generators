function URLEncode (clearString) {
	var output = '';
	var x = 0;
	clearString = clearString.toString();
	var regex = /(^[a-zA-Z0-9_.]*)/;
	while (x < clearString.length) {
		var match = regex.exec(clearString.substr(x));
		if (match != null && match.length > 1 && match[1] != '') {
			output += match[1];
			x += match[1].length;
		} else {
			if (clearString[x] == ' ') {
				output += '+';
			} else {
				var charCode = clearString.charCodeAt(x);
				var hexVal = charCode.toString(16);
				output += '%' + ( hexVal.length < 2 ? '0' : '' ) + hexVal.toUpperCase();
			}
			x ++;
		}
	}
	return output;
}

$(document).ready(function() {
	$("#preview").click(function () {
		$("#temppreview").val("preview");
	});
	$("#publish").click(function () {
		$("#temppublish").val("publish");
	});
	$("#lastweek").css('font-weight','bold');
	$("#thisweek").click(function() {
		$('#lastweekimg').fadeTo('slow', 0);
		$("#thisweek").css('font-weight','bold');
		$("#lastweek").css('font-weight','normal');
	});
	$("#lastweek").click(function() {
		$('#lastweekimg').fadeTo('slow', 1);
		$("#thisweek").css('font-weight','normal');
		$("#lastweek").css('font-weight','bold');
	});
	
	// $("#galleries_list ul li"):nth-child(n).addClass('leader');
	
	$("a").click(function() {
		if ($(this).attr("id") == "notick" || $(this).attr("id") == "tick") {
			$.get($(this).attr("href"));
			$(this).find("img").fadeOut("fast");
			$(this).find("img").attr('src', "/admin/img/" + $(this).attr("id") + ".png");
			$(this).find("img").fadeIn("fast");
			if ($(this).attr("id") == "notick") {
				$(this).attr('id', 'tick');
			} else {
				$(this).attr('id', 'notick');
			}
			return false;
		}
	});
});

$(document).ready(function() {
	$("a").click(function() {
		if ($(this).attr("id") == "delete") {
			if (confirm('Are you sure?')) {
				$.get($(this).attr("href"));
				$(this).parent().parent().fadeOut("slow");
				$(this).parent().parent().nextAll('.even').attr("class", "odd2");
				$(this).parent().parent().nextAll('.odd').attr("class", "even");
				$(this).parent().parent().nextAll('.odd2').attr("class", "odd");
				$("#noticeholder").append("<div id='tmpnotice' style='display:none'><div class='flash notice'>Item deleted</div></div>");
				$("#tmpnotice").slideDown("slow");
			}
			return false;
		}
		if ($(this).attr("id") == "reset") {
			if (confirm('Are you sure?')) {
				$.get($(this).attr("href"));
				$(this).parent().html("0");
			}
			return false;
		}
		if ($(this).attr("class") == "incoming_link") {
			id = $(this).attr("href").replace("?", "");
			$("#links" + id).load('/admin/news/incoming_links/' + id, {}, function() {
				$("#links" + id).slideToggle("slow");
			});
			return false;
		}
		if ($(this).attr("class") == "deleteimage") {
			if (confirm('Are you sure?')) {
				$.get($(this).attr("href"));
				$(this).parent().hide("slow");
				$("#noticeholder").append("<div id='tmpnotice' style='display:none'><div class='flash notice'>Item deleted</div></div>");
				$("#tmpnotice").slideDown("slow");
			}
			return false;
		}
		if ($(this).attr("class") == "deletegallery") {
			if (confirm('Are you sure?')) {
				$.get($(this).attr("href"));
				$(this).parent().hide("slow");
				$("#noticeholder").append("<div id='tmpnotice' style='display:none'><div class='flash notice'>Gallery deleted</div></div>");
				$("#tmpnotice").slideDown("slow");
			}
			return false;
		}
	});
});

// Below is taken from admin_template

function URLEncode (clearString) {
  var output = '';
  var x = 0;
  clearString = clearString.toString();
  var regex = /(^[a-zA-Z0-9_.]*)/;
  while (x < clearString.length) {
    var match = regex.exec(clearString.substr(x));
    if (match != null && match.length > 1 && match[1] != '') {
    	output += match[1];
      x += match[1].length;
    } else {
      if (clearString[x] == ' ')
        output += '+';
      else {
        var charCode = clearString.charCodeAt(x);
        var hexVal = charCode.toString(16);
        output += '%' + ( hexVal.length < 2 ? '0' : '' ) + hexVal.toUpperCase();
      }
      x++;
    }
  }
  return output;
}



// function stop_sort(Event, ui)
// {
// url = "http://cms.web2.kyanmedia.net/admin/index.php/main/update_nav/" + $("#nav_list").sortable("serialize");
// 
// 	$.get(url);
// }

	$(document).ready(function() {
		
	$("#preview").click(function () { 
			$("#temppreview").val("preview"); 
	});
	
	$("#publish").click(function () { 
			$("#temppublish").val("publish"); 
	});
			
	$("#lastweek").css('font-weight','bold');
	    	$("#thisweek").click(function() {
		$('#lastweekimg').fadeTo('slow', 0);
		$("#thisweek").css('font-weight','bold');
		$("#lastweek").css('font-weight','normal');
		});

		$("#lastweek").click(function() {
	$('#lastweekimg').fadeTo('slow', 1);
	$("#thisweek").css('font-weight','normal');
	$("#lastweek").css('font-weight','bold');
	});




	   $("a").click(function() {
		if ($(this).attr("id") == "notick" || $(this).attr("id") == "tick")
		{
	  		$.get($(this).attr("href"));
			$(this).find("img").fadeOut("fast");
			$(this).find("img").attr('src', "/admin/newimg/" + $(this).attr("id") + ".png") ;
			$(this).find("img").fadeIn("fast");
			if ($(this).attr("id") == "notick")
				$(this).attr('id', 'tick');	
			else
				$(this).attr('id', 'notick');
		 	return false;
		}

	   });
	 });
	

	
	$.fn.setAllToMaxHeight = function(){
	return this.height( Math.max.apply(this, $.map( this , function(e){ return $(e).height() }) ) );
	}
	$(document).ready(function() {
		$('#primary, #secondary').setAllToMaxHeight()
	});
	
	$(document).ready(function() {

		$("#tablesort").tablesorter(); 
		// $("#nav_list").sortable({ 
		//     placeholder: "ui-selected", 
		//     revert: true ,
		// 	stop: stop_sort,
		// 	cursor: 'move'
		// });
		
	   $("a").click(function() {

		if ($(this).attr("id") == "delete")
		{
			if (confirm('Are you sure?'))
			{
				$.get($(this).attr("href"));				
				$(this).parent().parent().fadeOut("slow");
				$(this).parent().parent().nextAll('.even').attr("class", "odd2");
				$(this).parent().parent().nextAll('.odd').attr("class", "even");
				$(this).parent().parent().nextAll('.odd2').attr("class", "odd");
				$("#noticeholder").append("<div id='tmpnotice' style='display:none'><div class='flash notice'>Item deleted</div></div>");
				$("#tmpnotice").slideDown("slow");

			}
				return false;
		}

		if ($(this).attr("id") == "reset")
		{
			if (confirm('Are you sure?'))
			{
				$.get($(this).attr("href"));
				$(this).parent().html("0");	
			}
				return false;			
		}

		if ($(this).attr("class") == "incoming_link")
		{
			id = $(this).attr("href").replace("?","")
			$("#links" + id).load('/admin/news/incoming_links/' + id,{}, function(){$("#links" + id).slideToggle("slow");});
			return false;
		}
		
			if ($(this).attr("class") == "deleteimage")
			{
				if (confirm('Are you sure?'))
				{
					$.get($(this).attr("href"));
					$(this).parent().parent().hide("slow");
					$("#noticeholder").append("<div id='tmpnotice' style='display:none'><div class='flash notice'>Image deleted</div></div>");
					$("#tmpnotice").slideDown("slow");	
				}
					return false;
			}	
	   });
});
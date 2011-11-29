$(function(){
	
	// homepage 
	$('#gallery').gallerify();
	$('#client_list').logoSlider();
	
	// clients page
	$('#client_nav').clientNav();
	
});

$.fn.gallerify = function(){
	return this.each(function(){
		var items = $('#slides>li');
		var markers = $('<ol class="markers" />').appendTo(this);
		var crossFade = function(e){
			e.preventDefault();
			items.filter(':visible').fadeOut();
			items.eq(e.data.index).fadeIn();
			markers.children().removeClass('current').eq(e.data.index).addClass('current');
		}
		
		items.each(function(i){
			var marker = $('<li><a href="#"><span>Show slide </span>'+(i+1)+'</a></li>');
			if (i==0) marker.addClass('current');
			marker.children().click({index:i},crossFade);
			marker.appendTo(markers);
		});
		
	});
}

$.fn.logoSlider = function(){
	return this.each(function(){
		var list = $(this).children();
		var ul = list.find('ul');
		var items = ul.children('li');
		
		var slide = function(e){
			if(!list.is(':animated')) {
				var currentScroll = list.scrollLeft();
				var scrollAmount = list.width();
				var itemsWidth = ul.width()/2;

				if (e.data.direction == 'next') {
					list.animate({scrollLeft: currentScroll+scrollAmount},{duration: 500, complete:function(){
						if (list.scrollLeft()>=itemsWidth) list.scrollLeft(list.scrollLeft()-itemsWidth);
					}});
				} else {
					list.animate({scrollLeft: currentScroll-scrollAmount},{duration: 500, complete:function(){
						if (list.scrollLeft()<=0) list.scrollLeft(itemsWidth);
					}});
				}
			}
		}
		
		if (items.length>4) {
			items.clone().appendTo(ul);
			items = ul.children('li');
			$('<button id="prev"><img src="/client/img/button_prev.png" alt="Previous clients" /></button>').bind('click',{direction:'prev'},slide).insertAfter(list);
			$('<button id="next"><img src="/client/img/button_next.png" alt="More clients" /></button>').bind('click',{direction:'next'},slide).insertAfter(list);
			list.scrollLeft(0);
		}
		
		// resize logos on window resize
		var resizeItems = function(){
			var itemWidth = list.width()/4;
			items.width(itemWidth);
			ul.width(itemWidth*items.length);
		}
		$(window).resize(resizeItems).resize();
		
	});
}

$.fn.clientNav = function(){
	return this.each(function(){
		$(this).find('a').click(function(e){
			var link = $(this);
			e.preventDefault();
			link.parent().addClass('on').siblings().removeClass('on');
			$(link.attr('href')).show().siblings('ul').hide();
		}).first().click();
	});
}
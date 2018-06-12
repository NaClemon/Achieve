(function ($) {
 "use strict";
$(document).ready(function(){
	  
		/*
		Mean Menu Responsive
		============================*/		
        jQuery('nav#main-menu').meanmenu();						
		/*
		Testimonial Crousel
		============================*/ 
		
		  $(".all-testimonial").owlCarousel({
			autoPlay: false, 
			slideSpeed:2000,
			pagination:false,
			navigation:true, 
			items :1,
			navigationText:["<i class='fa fa-angle-left'></i>","<i class='fa fa-angle-right'></i>"],
			itemsDesktop : [1199,1],
			itemsDesktopSmall : [980,1],
			itemsTablet: [768,1],
			itemsTablet: [767,1],
			itemsMobile : [479,1],
		  });
		  		
		
		/*
		Slider Crousel
		============================*/ 
		$(".all-slide").owlCarousel({
            items: 1,
            nav: true,
            dots: true,
            autoplay: true,			
            loop: true,
            navText: ["<i class='fa fa-angle-left'></i>", "<i class='fa fa-angle-right'></i>"],
            mouseDrag: false,
            touchDrag: false,
        });
        
        $(".all-slide").on("translate.owl.carousel", function(){	
            $(".slider-text *").removeClass("animated fadeInUp").css("opacity", "0");
        });
        
        $(".all-slide").on("translated.owl.carousel", function(){
            $(".slider-text *").addClass("animated fadeInUp").css("opacity", "1");
        });
		/*
		Team Crousel
		============================*/	  
		  $(".all-team").owlCarousel({
			autoPlay: true, 
			slideSpeed:2000,
			pagination:true,
			navigation:false, 
			items : 4,
			responsive:{
				0:{
					items:1
				},
				600:{
					items:2
				},
				768:{
					items:3
				},				
				1000:{
					items:4
				}
			}	
		  });		  

		/*
		scrollUp
		============================*/	
		$.scrollUp({
			scrollText: '<i class="fa fa-angle-up"></i>',
			easingType: 'linear',
			scrollSpeed: 900,
			animation: 'fade'
		});	
		/*
		Counter Js
		============================*/ 
        $('.counter').counterUp({
            delay: 10,
            time: 1000			
        }); 				

		/*
		Project Gallery Js
		============================*/	
		$(".gallery-container").isotope({
		itemSelector: '.filtr-item',
		layoutMode: 'fitRows',
		});
		$("ul.simplefilter li").on("click",function(){
		$("ul.simplefilter li").removeClass("active");
		$(this).addClass("active");
		 
		var selector = $(this).attr('data-filter');
		$(".gallery-container").isotope({
		filter: selector,
		animationOptions: {
		duration: 750,
		easing: 'linear',
		queue: false,
		}
		});
		return false;
		});		
		/*
		Preeloader
		============================*/
		$(window).load(function() {
			$('#preloader').fadeOut();
			$('#preloader-status').delay(200).fadeOut('slow');
			$('body').delay(200).css({'overflow-x':'hidden'});
		});	
		
	});	
})(jQuery);


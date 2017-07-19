var f1 = function(){
      $('.btn-toggle').find('.btn').toggleClass('active');  
    
      if ($('.btn-toggle').find('.btn-outline-success').size()>0) {
    	$('.btn-toggle').find('.btn').toggleClass('btn-outline-success');
      }
    
      $('.btn-toggle').find('.btn').toggleClass('btn-secondary');
      
      $(".header").toggleClass("light-header", 1000);
	  $("body").toggleClass("body_light");
 	  $(".footer").toggleClass("light-header", 1000);   
}
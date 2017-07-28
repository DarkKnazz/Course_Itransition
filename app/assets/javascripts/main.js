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

$(function  () {
  $("tbody.example").sortable();
});

var ajax_Request = function(){
  var temp = $("#form1").val();
  $.ajax({
        url : "/clear",
        type : "post",
        data : { data_value: JSON.stringify(temp) }
    });
}

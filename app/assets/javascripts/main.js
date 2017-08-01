function updateDiv(){
    window.location.reload();
}

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

var drop = document.querySelector('#steps_List');



var ready, set_positions;

set_positions = function(){
    // loop through and give each task a data-pos
    // attribute that holds its position in the DOM
    $('.list_Item').each(function(i){
        $(this).attr("data-pos",i+1);
    });
}

$(document).ready(function(){
    // call set_positions function

    set_positions();

    $('#steps_List').sortable();

    $('#steps_List').sortable().bind('sortupdate', function(e, ui) {
        // array to store new order
        updated_order = []
        // set the updated positions
        set_positions();

        // populate the updated_order array with the new task positions
        $('.list_Item').each(function(i){
            updated_order.push({ id: $(this).data("id"), position: i+1 });
        });

        // send the updated order via ajax
        $.ajax({
            type: "PUT",
            url: '/steps/sort',
            data: { order: updated_order }
        });
    });
});

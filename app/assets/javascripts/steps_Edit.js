var global_counter=  1;
$(document).ready(function(){
  if(document.getElementById("upload_widget_opener")){
    document.getElementById("upload_widget_opener").addEventListener("click", function() {
      cloudinary.openUploadWidget({ cloud_name: 'dgyxtx2pm', upload_preset: 'acjwzy3r'},
        function(error, result) { console.log(result[0].secure_url);create_new_image(result[0].secure_url) });
    }, false);
  }
});

$(function  () {
  $("ol.drag_list").sortable({ containment: "parent" });
});

var create_new_text = function(){
  var list_body = document.getElementById("main_block");
  var list_child = $("<li class='ui-sortable-handle'></li>");
  var child_body = $("<div class='row block text'></div>");
  var child_header = $('<div class="block_text_field">Text</div>');
  var textarea = $('<textarea class="form-control block_text_area" rows="3"></textarea>');
  var button = $('<button class="btn btn-danger">Destroy</button>');

  $(list_child).attr("id", global_counter);
  $(button).attr("id", global_counter + "_button");
  $(button).attr("onclick", "delete_function(id)");

  $(child_body).append(child_header, textarea, button);
  $(list_child).append(child_body);
  $(list_body).append(list_child);
  global_counter++;
}

var create_new_image = function(value){
  var list_body = document.getElementById("main_block");
  var list_child = $("<li class='ui-sortable-handle'></li>");
  var child_body = $("<div class='row block image'></div>");
  var child_header = $('<div class="block_text_field">Image</div>');
  var image_body = $("<div class='block_image'></div>");
  var image_block = $('<img>');
  var button = $('<button class="btn btn-danger">Destroy</button>');

  $(list_child).attr("id", global_counter);
  $(button).attr("id", global_counter + "_button");
  $(button).attr("onclick", "delete_function(id)");
  $(image_block).attr("src", value);

  $(image_body).append(image_block);
  $(child_body).append(child_header, image_body, button);
  $(list_child).append(child_body);
  $(list_body).append(list_child);

  global_counter++;
}

var create_new_video = function(){
  var list_body = document.getElementById("main_block");
  var list_child = $("<li class='ui-sortable-handle'></li>");
  var child_body = $("<div class='row block video'></div>");
  var child_header = $('<div class="block_text_field">Video</div>');
  var textarea = $('<input type="text" placeholder="Your link" class="form-control block_text_area">');
  var button = $('<button class="btn btn-danger">Destroy</button>');

  $(list_child).attr("id", global_counter);
  $(button).attr("id", global_counter + "_button");
  $(button).attr("onclick", "delete_function(id)");

  $(child_body).append(child_header, textarea, button);
  $(list_child).append(child_body);
  $(list_body).append(list_child);
  global_counter++;
}

var delete_function = function(id){
  var delete_id = "#"+ id.split("_")[0];
  $(delete_id).fadeOut(500);
  setTimeout(function(){$(delete_id).remove();}, 1000);
}

var ajax_request = function(){
  var temp = "";
  var elements_of_step = document.getElementsByClassName("block");
  var id_block = document.getElementsByClassName("edit_step_success")[0].attributes[3].value.split("B")[0];
  for(var i = 0; i < elements_of_step.length; i++){
    if($( elements_of_step[i] ).hasClass( "text" )){
      var value_text;
      if(elements_of_step[i].childNodes.length == 7)
        value_text = elements_of_step[i].childNodes[3].value;
      else
        value_text = elements_of_step[i].childNodes[1].value;
      temp += "%block%<p %text% >" + value_text + "</p>";
    }
    if($( elements_of_step[i] ).hasClass( "image" )){
      var value_image;
      if(elements_of_step[i].childNodes.length == 7)
        value_image = elements_of_step[i].childNodes[3].childNodes[1].attributes[0].value;
      else
        value_image = elements_of_step[i].childNodes[1].childNodes[0].attributes[0].value
      temp += "%block%<img %image% src='" + value_image + "' class='show_inner_image'>";
    }

    if($( elements_of_step[i] ).hasClass( "video" )){
      var value_video;
      if(elements_of_step[i].childNodes.length == 7)
        value_video = elements_of_step[i].childNodes[3].value.split("v=")[1].split("&")[0];
      else
        value_video = elements_of_step[i].childNodes[1].value.split("v=")[1].split("&")[0];
      temp += "%block%<iframe %video% width='100%' height='350' src='https://www.youtube.com/embed/" + value_video + "' frameborder='0' allowfullscreen></iframe>"
    }
  }
  $.ajax({
        url : "/update_step",
        type : "post",
        data : { data_value: temp,
                 id: id_block },
        success: function(){
          var title = document.location.href;
          var post_id = title.split("/")[4];
          var edit_post_title = "/posts/" + post_id + "/edit";
          document.location.href = edit_post_title;
        }
    });
}

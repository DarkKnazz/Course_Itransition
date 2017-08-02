var global_Counter=  1;

$(document).ready(function(){
  if(document.getElementById("upload_widget_opener")){
    document.getElementById("upload_widget_opener").addEventListener("click", function() {
      cloudinary.openUploadWidget({ cloud_name: 'dgyxtx2pm', upload_preset: 'acjwzy3r'},
        function(error, result) { console.log(result[0].secure_url);create_New_Image(result[0].secure_url) });
    }, false);
  }
});

$(function  () {
  $("ol.drag_List").sortable({ containment: "parent" });
});

var create_New_Text = function(){
  var list_Body = document.getElementById("main_Block");
  var list_Child = $("<li class='ui-sortable-handle'></li>");
  var child_Body = $("<div class='row block text'></div>");
  var child_Header = $('<div class="block_Text_Field">Text</div>');
  var textarea = $('<textarea class="form-control block_Text_Area" rows="3"></textarea>');
  var button = $('<button class="btn btn-danger">Destroy</button>');

  $(list_Child).attr("id", global_Counter);
  $(button).attr("id", global_Counter + "_button");
  $(button).attr("onclick", "delete_Function(id)");

  $(child_Body).append(child_Header, textarea, button);
  $(list_Child).append(child_Body);
  $(list_Body).append(list_Child);
  global_Counter++;
}

var create_New_Image = function(value){
  var list_Body = document.getElementById("main_Block");
  var list_Child = $("<li class='ui-sortable-handle'></li>");
  var child_Body = $("<div class='row block image'></div>");
  var child_Header = $('<div class="block_Text_Field">Image</div>');
  var image_Body = $("<div class='block_Image'></div>");
  var image_Block = $('<img>');
  var button = $('<button class="btn btn-danger">Destroy</button>');

  $(list_Child).attr("id", global_Counter);
  $(button).attr("id", global_Counter + "_button");
  $(button).attr("onclick", "delete_Function(id)");
  $(image_Block).attr("src", value);

  $(image_Body).append(image_Block);
  $(child_Body).append(child_Header, image_Body, button);
  $(list_Child).append(child_Body);
  $(list_Body).append(list_Child);

  global_Counter++;
}

var create_New_Video = function(){
  var list_Body = document.getElementById("main_Block");
  var list_Child = $("<li class='ui-sortable-handle'></li>");
  var child_Body = $("<div class='row block video'></div>");
  var child_Header = $('<div class="block_Text_Field">Video</div>');
  var textarea = $('<input type="text" placeholder="Your link" class="form-control block_Text_Area">');
  var button = $('<button class="btn btn-danger">Destroy</button>');

  $(list_Child).attr("id", global_Counter);
  $(button).attr("id", global_Counter + "_button");
  $(button).attr("onclick", "delete_Function(id)");

  $(child_Body).append(child_Header, textarea, button);
  $(list_Child).append(child_Body);
  $(list_Body).append(list_Child);
  global_Counter++;
}

var ajax_Request = function(){
  var temp = "";
  var elements_Of_Step = document.getElementsByClassName("block");
  var id_Block = document.getElementsByClassName("edit_Step_Success")[0].attributes[3].value.split("B")[0];
  console.log(id_Block);
  for(var i = 0; i < elements_Of_Step.length; i++){
    if($( elements_Of_Step[i] ).hasClass( "text" )){
      var value_Text = elements_Of_Step[i].childNodes[1].value;
      temp += "<div class='row show_Text'>" +
                "<div class='col-lg-1'></div>" +
                  "<div class='col-lg-10'>" +
                    value_Text +
                  "</div>" +
                "<div class='col-lg-1'></div>" + "</div>";
    }
    if($( elements_Of_Step[i] ).hasClass( "image" )){
      var value_Image = elements_Of_Step[i].childNodes[1].childNodes[0].attributes[0].value
      temp += "<div class='row show_Image'>" +
                "<div class='col-lg-1'></div>" +
                  "<div class='col-lg-10' style='text-align:center'>" +
                    "<img src='" + value_Image + "' class='show_Inner_Image'>" +
                  "</div>" +
                "<div class='col-lg-1'></div>" + "</div>";
    }

    if($( elements_Of_Step[i] ).hasClass( "video" )){
      var value_Video = elements_Of_Step[i].childNodes[1].value.split("v=")[1];
      temp += "<div class='row show_Video'>" +
                "<div class='col-lg-3'></div>" +
                  "<div class='col-lg-6'>" +
                    "<iframe width='100%' height='100%' src='https://www.youtube.com/embed/" + value_Video + "' frameborder='0' allowfullscreen></iframe>"
                  "</div>" +
                "<div class='col-lg-3'></div>" + "</div>";
    }
  }
  $.ajax({
        url : "/clear",
        type : "post",
        data : { data_value: temp,
                 id: id_Block },
        success: function(){
          window.location.href="/posts";
        }


    });
}



var delete_Function = function(id){
  var delete_Id = "#"+ id.split("_")[0];
  $(delete_Id).fadeOut(500);
  setTimeout(function(){$(delete_Id).remove();}, 1000);
}

var global_Counter=  1;
var func_Fuck = function(id){
  var temp_img = id + " img";
  var temp_div = id + " div";
  $(id).on('dragover', function() {
    $(this).addClass('hover');
  });

  $(id).on('dragleave', function() {
    $(this).removeClass('hover');
  });
  var input_Temp = id + " input";
  $(input_Temp).on('change', function(e) {
    var file = this.files[0];

    $(id).removeClass('hover');

    if (this.accept && $.inArray(file.type, this.accept.split(/, ?/)) == -1) {
      return alert('File type not allowed.');
    }

    $(id).addClass('dropped');
    $(temp_img).remove();

    if ((/^image\/(gif|png|jpeg)$/i).test(file.type)) {
      var reader = new FileReader(file);

      reader.readAsDataURL(file);

      reader.onload = function(e) {
        var data = e.target.result,
            $img = $('<img />').attr('src', data).fadeIn();
        $(temp_div).html($img);
      };
    } else {
      var ext = file.name.split('.').pop();

      $(temp_div).html(ext);
    }
  });
}
$(function() {
  var temp = document.getElementsByClassName("dropzone");
  console.log(temp);
  for(var i = 0; i < temp.length; i++){
    func_Fuck("#" + temp[i].id)
  }
});

$(function  () {
  $("ol.drag_List").sortable();
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

var create_New_Image = function(){
  console.log(global_Counter);
  global_Counter++;
}

var create_New_Video = function(){
  console.log(global_Counter);
  global_Counter++;
}

var delete_Function = function(id){
  var delete_Id = "#"+ id.split("_")[0];
  $(delete_Id).fadeOut(500);
  setTimeout(function(){$(delete_Id).remove();}, 1000);
}

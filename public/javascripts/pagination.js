$(function() {
  $("#steps_List_Show").on("click", ".pagination a", function(){
    $.getScript(this.href);
    return false;
  });
});

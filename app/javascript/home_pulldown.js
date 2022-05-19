$(document).bind("ready ajaxComplete turbolinks:load", function() {
  $(".select-drop-project").change(function() {
    let inputpulldown = $(".select-drop-project").val();
      if (inputpulldown == ""){
        return;
      }else{
        $("#select-drop-submit > input[type='submit']").click()
      }
    });
});
$(document).ready(function() {
  $(".user").draggable();

  $(".user .delete").click(function(){
    $(this).parent().remove();
  })
});
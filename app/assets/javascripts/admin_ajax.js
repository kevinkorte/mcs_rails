$(document).ready(function(){
  $('#all-list-group').on("click", ".machine-checkbox", function(){
    console.log("Checkbox Changed");
    $(this).parent().clone().appendTo("#list-group-form");
  });
  
  $("#machine_filter input").keyup(function() {
    $.get($("#machine_filter").attr("action"), $("#machine_filter").serialize(), null, "script");
    return false;
  });
});
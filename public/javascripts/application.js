jQuery(function($){
  $("#main-nav .login").toggle(function(event) {
    event.preventDefault();
    var target = $(this).attr("target");
    $(target).slideDown();
  }, function(event) {
    event.preventDefault();
    var target = $(this).attr("target");
    $(target).slideUp();    
  });

  setTimeout(function() {
    $("#messages").slideDown(function() {
      setTimeout(function() {
        $("#messages").slideUp();
      }, 2000);
    });
  }, 750);

  $("#main-nav ul.pulldown").each(function() {
    $(this).closest("li").dropdown();
  });

  $(".flipflop").click(function(event) {
    var str = $(this).closest("form").serialize();
    jQuery.post($(this).closest("form").attr("action")+".js",
                str,
                function(data,status){ },
                "script");
    event.preventDefault();
  });     
  $(".ui-date").datepicker({
    changeMonth: true,
    changeYear: true,
    yearRange: '1900:' + ((new Date()).getYear() + 1900)
  });
});

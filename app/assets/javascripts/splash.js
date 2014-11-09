
$(document).ready(function(){


  $(".splash-page").fadeIn(4000);


  $(".login-link").click(function() {
    $(".splash-page").fadeOut(1200);
    $(".login").delay(1200).fadeIn(1200);
  });


  $(".exit").click(function() {
    $(".login").fadeOut(1200);
    $(".splash-page").delay(3000).fadeIn(4000);
  });


});

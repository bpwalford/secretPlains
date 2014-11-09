
// var firstVisit = true;

$(document).ready(function(){
// location.reload();

  // if ( $(".splash-page").css("display") == "none" ) {
    $(".splash-page").fadeIn(4000);
    // firstVisit = false
  // } else {
    // $(".splash-page").show();
  // }


  $(".login-link").click(function() {
    $(".splash-page").fadeOut(1200);
    $(".login").delay(1200).fadeIn(1200);
  });


  $(".exit").click(function() {
    $(".login").fadeOut(1200);
    $(".splash-page").delay(3000).fadeIn(4000);
  });

});

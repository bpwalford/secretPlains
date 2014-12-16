
function setPrint(){
  fingerPrinter = new FingerPrinter();
  plugins = fingerPrinter.fingerPrint;
  $("input#plugins").val(plugins['plugins']);
  $("input#fonts").val(plugins['fonts']);
  $("input#version").val(plugins['version']);
  $("input#language").val(plugins['language']);
  $("input#agent").val(plugins['agent']);
  $("input#cookies").val(plugins['cookies']);
};

$(document).ready(function(){

  $(".splash-page").fadeIn(1000);

  $(".login-link").click(function() {
    $(".splash-page").fadeOut(500);
    $(".register").fadeOut(500);
    $(".login").delay(500).fadeIn(500);
  });

  $(".register-link").click(function() {
    $(".splash-page").fadeOut(500);
    $(".login").fadeOut(500);
    $(".register").delay(500).fadeIn(500);
  });

  $(".exit").click(function() {
    $(".login").fadeOut(500);
    $(".register").fadeOut(500);
    $(".splash-page").delay(500).fadeIn(1000);
  });

});

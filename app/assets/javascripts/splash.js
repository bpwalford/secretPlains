
function setPrint(){
  fingerPrinter = new FingerPrinter();
  plugins = fingerPrinter.fingerPrint;

  $("input#plugins").val(plugins['plugins']);
  $("input#fonts").val(plugins['fonts']);
  $("input#version").val(plugins['version']);
  $("input#language").val(plugins['language']);
  $("input#agent").val(plugins['agent']);
  $("input#cookies").val(plugins['cookies']);

  $("input#session_plugins").val(plugins['plugins']);
  $("input#session_fonts").val(plugins['fonts']);
  $("input#session_version").val(plugins['version']);
  $("input#session_language").val(plugins['language']);
  $("input#session_agent").val(plugins['agent']);
  $("input#session_cookies").val(plugins['cookies']);
};

function setPageState(){
  var path  = window.location.href;
  var param = path.split('+');

  if(param[param.length -1] == 'fingerprint') {
    $(".login").fadeIn(200);
  } else if(param[param.length -1] == 'valid') {
    $(".register").fadeIn(200);
  } else {
    $(".splash-page").fadeIn(1000);
  }
}

$(document).ready(function(){

  setPageState();

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

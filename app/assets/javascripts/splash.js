function setPrint(){
  fingerPrinter = new FingerPrinter();
  print = fingerPrinter.fingerPrint;

  var height = screen.height.toString();
  var width  = screen.width.toString();
  var dimensions = height + 'x' + width;

  $("input#plugins").val(print['plugins']);
  $("input#fonts").val(print['fonts']);
  $("input#version").val(print['version']);
  $("input#language").val(print['language']);
  $("input#agent").val(print['agent']);
  $("input#cookies").val(print['cookies']);
  $("input#screen").val(dimensions);

  $("input#session_plugins").val(print['plugins']);
  $("input#session_fonts").val(print['fonts']);
  $("input#session_version").val(print['version']);
  $("input#session_language").val(print['language']);
  $("input#session_agent").val(print['agent']);
  $("input#session_cookies").val(print['cookies']);
  $("input#session_screen").val(dimensions);

  $.getJSON("http://www.telize.com/geoip?callback=?", function(json) {
    $("input#ip").val(json.ip);
    $("input#country").val(json.country);
    $("input#session_ip").val(json.ip);
    $("input#session_country").val(json.country);
  });
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
  setPrint();

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

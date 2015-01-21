function setPrint(postPath, redirectPath){
  fingerPrinter = new FingerPrinter();
  var newPrint = fingerPrinter.fingerPrint;

  $.getJSON("http://www.telize.com/geoip?callback=?")
    .then(function(json) {
      return {
        ip: json.ip,
        country: json.country
      };
    }).then(doStuffWithGeoIp(postPath, newPrint, redirectPath));
};

function doStuffWithGeoIp(postPath, newPrint, redirectPath) {
  return function(geoIp) {
    console.log(geoIp);
    $.post(postPath, newPrint, function() {
      document.location = redirectPath;
    })
  }
}

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

$(function () {
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

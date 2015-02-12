function setPrint(postPath, redirectPath){
  fingerPrinter = new FingerPrinter();
  var newPrint = fingerPrinter.fingerPrint;

  $.getJSON("https://www.telize.com/geoip?callback=?")
    .then(function(json) {
      return {
        ip: json.ip,
        country: json.country
      };
    }).then(addGeoIp(postPath, newPrint, redirectPath));
};

function addGeoIp(postPath, newPrint, redirectPath) {
  return function(geoIp) {
    newPrint.ip = geoIp.ip
    newPrint.country = geoIp.country
    $.post(postPath, newPrint, function() {
      document.location = redirectPath;
    })
  }
}

$(function () {
  setTimeout(function () {
    $('.notice').fadeOut(3000);
  }, 2000);

  $(".login-link").click(function() {
    $(".splash-page").fadeOut(500);
    $(".about").fadeOut(500);
    $(".register").fadeOut(500);
    $(".login").delay(500).fadeIn(500);
  });

  $(".register-link").click(function() {
    $(".splash-page").fadeOut(500);
    $(".about").fadeOut(500);
    $(".login").fadeOut(500);
    $(".register").delay(500).fadeIn(500);
  });

  $(".exit").click(function() {
    $(".login").fadeOut(500);
    $(".register").fadeOut(500);
    $(".splash-page").delay(500).fadeIn(1000);
    $(".about").delay(500).fadeIn(1000);
  });
});

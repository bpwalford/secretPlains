ipPrinter = function(){

  ip = {}

  $.getJSON("http://www.telize.com/jsonip?callback=?",  function(json) {
      ip.ip = json.ip;
      ip.country_code = json.country_code
      ip.country = json.country
      ip.continent_code = json.continent_code
      ip.latitude = json.latitude
      ip.longitude = json.longitude
      ip.area_code = json.area_code
      ip.asn = json.asn
      ip.isp = json.isp
      ip.timezone = json.timezone
  });

  this.ip = ip
}

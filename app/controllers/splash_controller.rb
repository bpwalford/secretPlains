class SplashController < ApplicationController

  def index
    @ip = request.remote_ip
    userIp = Geocoder.search(@ip)[0].data

    @ip           = userIp['ip']
    @city         = userIp['city']
    @region_code  = userIp['region_code']
    @region_name  = userIp['region_name']
    @metrocode    = userIp['metrocode']
    @zipcode      = userIp['zipcode']
    @latitude     = userIp['latitude']
    @longitude    = userIp['longitude']
    @country_name = userIp['country_name']
    @country_code = userIp['country_code']
  end

  def test
  end

end

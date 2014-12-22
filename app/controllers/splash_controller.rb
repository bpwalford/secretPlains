class SplashController < ApplicationController

  def index
    @ip = request.remote_ip
    @userIp = Geocoder.search(@ip)
  end

  def test
  end

end

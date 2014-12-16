class SplashController < ApplicationController

  def index
  end

  def test

    @userIp = request.remote_ip

    @ipBreakDown = Geocoder.search(@userIp)
    @Gip = Geocoder.search("128.177.172.2")

    @bar = Array.new

    @var = request.env['HTTP_USER_AGENT']

  end

end

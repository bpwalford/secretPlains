class SplashController < ApplicationController

  def index

    @userIp = request.remote_ip

    @ipBreakDown = Geocoder.search("76.25.195.243")
    @Gip = Geocoder.search("128.177.172.2")

    @bar = Array.new

    @var = request.env['HTTP_USER_AGENT']

  end

end

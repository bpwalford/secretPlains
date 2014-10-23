class SplashController < ApplicationController

  def index
    @user = request.location.country
    @user2 = request.location.region_name
    @user3 = request.location.city
  end

end

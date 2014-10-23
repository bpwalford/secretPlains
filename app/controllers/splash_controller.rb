class SplashController < ApplicationController

  def index
    @user = request.location.country
    @user3 = request.location.city
  end

end

class SplashController < ApplicationController

  def index
    @user = request.location.country
  end

end

class SplashController < ApplicationController

  def index
    @user = request.location.country
    # @user2 = request.location.region
  end

end

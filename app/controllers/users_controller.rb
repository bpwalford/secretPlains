class UsersController < ApplicationController

  def create
    user = User.new(params.permit(:email))
    if user.save
      Fingerprint.create!(
        user: user,
        plugins: params[:plugins],
        fonts: params[:fonts],
        user_agent: params[:agent],
        browser_version: params[:version],
        cookies: params[:cookies],
        language: params[:language],
      )
      Ip.create!(
        user: user,
        country_code: params[:country_code],
        country_name: params[:country_name],
        longitude: params[:longitude],
        latitude: params[:latitude],
        zipcode: params[:zipcode],
        metrocode: params[:metrocode],
        region_name: params[:region_name],
        region_code: params[:region_code],
        city: params[:city],
        ip: params[:ip],
      )
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      redirect_to root_path(notice: 'email is taken or not valid')
    end
  end

  def show
    @user = User.find(params[:id])
    if !@user
      redirect_to login_path
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
  end

end

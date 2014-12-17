class UsersController < ApplicationController

  def create
    user = User.new(params.permit(:email))
# binding.pry
    if user.save
# binding.pry
      fingerprint = Fingerprint.create!(
        user: user,
        plugins: params[:plugins],
        fonts: params[:fonts],
        user_agent: params[:agent],
        browser_version: params[:version],
        cookies: params[:cookies],
        language: params[:language],
      )
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
# binding.pry
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

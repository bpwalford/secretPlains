class UsersController < ApplicationController

  def create
# binding.pry
    user = User.new(params.permit(:email))
    if user.save
      FingerprintBuilder.new(user, params).build
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

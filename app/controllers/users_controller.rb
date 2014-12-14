class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:email))
    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path
      # create a new finger print
    else
      render :new
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

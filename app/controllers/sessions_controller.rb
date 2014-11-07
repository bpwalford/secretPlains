class SessionsController < ApplicationController

  def index

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      redirect_to login_path, notice: 'invalid email'
    end
  end

  def destroy
    session.clear
    @current_user = nil
    redirect_to root_path
  end

end

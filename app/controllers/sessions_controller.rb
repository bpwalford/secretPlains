class SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:session][:email].downcase.strip)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to fingerprint_path
    else
      redirect_to root_path, notice: 'invalid email or password'
    end
  end

  def destroy
    session.clear
    @current_user = nil
    redirect_to root_path
  end

end

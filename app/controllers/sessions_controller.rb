class SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:session][:email].downcase.strip)
    if user
      session[:user_id] = user.id
      redirect_to fingerprint_path
    else
      redirect_to root_path(notice: 'invalid email or fingerprint')
    end
  end

  def destroy
    session.clear
    @current_user = nil
    redirect_to root_path
  end

end

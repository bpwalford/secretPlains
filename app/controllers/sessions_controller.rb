class SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:session][:email].downcase.strip)
    if user
      fingerprint = FingerprintBuilder.new(user, params[:session]).build
      difference  = DifferenceBuilder.new(user, fingerprint).build
      session[:user_id] = user.id
      redirect_to dashboard_path
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

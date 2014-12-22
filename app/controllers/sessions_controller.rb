class SessionsController < ApplicationController

  def create
# binding.pry
    user = User.find_by(email: params[:session][:email].downcase.strip)

    # scanner = FingerprintScanner.new(params[:session])

    if user
      FingerprintBuilder.new(user, params[:session]).build
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

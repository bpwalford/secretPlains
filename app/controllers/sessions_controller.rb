class SessionsController < ApplicationController

  def create
    binding.pry
    user = User.find_by(email: params[:session][:email].downcase.strip)

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

    scanner = FingerprintScanner.new(params[:session])
    confirmed = scanner.scan # need to get scanner working

    if user && confirmed
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

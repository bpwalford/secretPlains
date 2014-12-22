class FingerprintBuilder

  attr_reader :user, :params

  def initialize(user, params)
    @user = user
    @params = params
  end

  def build
    build_browser_instance
    build_ip_instance
  end

  private

  def build_browser_instance
    Fingerprint.create!(
      user: user,
      plugins: params[:plugins],
      fonts: params[:fonts],
      user_agent: params[:agent],
      browser_version: params[:version],
      cookies: params[:cookies],
      language: params[:language],
    )
  end

  def build_ip_instance
    corrected_ip = IpScanner.new(params[:ip]).build_ip

    Ip.create!(
      user: user,
      country_code: corrected_ip[:country_code],
      country_name: corrected_ip[:country_name],
      longitude: corrected_ip[:longitude],
      latitude: corrected_ip[:latitude],
      zipcode: corrected_ip[:zipcode],
      metrocode: corrected_ip[:metrocode],
      region_name: corrected_ip[:region_name],
      region_code: corrected_ip[:region_code],
      city: corrected_ip[:city],
      ip: corrected_ip[:ip],
    )
  end

end

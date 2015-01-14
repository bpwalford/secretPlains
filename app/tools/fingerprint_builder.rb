class FingerprintBuilder

  attr_reader :user, :params

  def initialize(user, params)
    @user = user
    @params = params
  end

  def build
    Fingerprint.create!(
      user: user,
      plugins: params[:plugins],
      fonts: params[:fonts],
      user_agent: params[:agent],
      browser_version: params[:version],
      cookies: params[:cookies],
      language: params[:language],
      screen: params[:screen],
      ip: params[:ip],
      country: params[:country],
    )
  end

end

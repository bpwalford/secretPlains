class FingerprintScanner

  attr_reader :fingerprint, :plugins, :fonts, :version, :cookies, :agent, :language, :user

  def initialize(fingerprint)
    @fingerprint  = "#{fingerprint[:plugins]}#{fingerprint[:fonts]}#{fingerprint[:agent]}#{fingerprint[:version]}#{fingerprint[:cookies]}#{fingerprint[:language]}"
    @plugins      = fingerprint[:plugins]
    @fonts        = fingerprint[:fonts]
    @version      = fingerprint[:version]
    @cookies      = fingerprint[:cookies]
    @agent        = fingerprint[:agent]
    @language     = fingerprint[:language]
    @user         = User.find_by(email: fingerprint[:email])
  end

  def scan
    return false if !user
    return false if user.fingerprints.first.print != fingerprint
    true
  end

end

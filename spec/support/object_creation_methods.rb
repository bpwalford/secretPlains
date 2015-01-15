module ObjectCreationMethods

  def new_user(overrides = {})
    defaults = {
      email: Faker::Internet::email
    }
    User.new(defaults.merge(overrides))
  end

  def create_user(overrides = {})
    new_user(overrides).tap(&:save!)
  end

  def new_fingerprint(overrides = {})
    defaults = {
      user: create_user,
      plugins: [
        ['plugin_one', 'v 1.0.0'],
        ['plugin_$','v2.3a']
      ],
      fonts: {
        font1: true,
        font2: false,
        font3: true,
        font4: false
      },
      user_agent: 'user_agent, browser, v1.2.3 %%',
      browser_version: 'version 1.3ba.6 %%',
      cookies: 'true',
      language: 'language',
      ip: '123.456.678',
      screen: '900x500',
      country: 'United States',
    }
    Fingerprint.new(defaults.merge(overrides))
  end

  def create_fingerprint(overrides = {})
    new_fingerprint(overrides).tap(&:save!)
  end

end

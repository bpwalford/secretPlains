module ObjectCreationMethods

  def new_user(overrides = {})
    defaults = {
      email: Faker::Internet::email,
      password: 'asdf'
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
        ['plugin_one', 'v 1.0.0', 'asdf !@#$'],
        ['plugin_two', 'v 3.5.3']
      ],
      fonts: {
        installed:   ['font1', 'font2', 'font3'],
        uninstalled: ['font4', 'font5', 'font6']
      },
      user_agent: 'user_agent, browser, v1.2.3 %%',
      browser: 'version 1.3ba.6 %%',
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

  def intersection_match?(actual, expected)
    expected.each{|i| return false if !actual.include?(i)}
    true
  end

end

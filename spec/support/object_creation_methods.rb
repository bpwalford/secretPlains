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

  def new_ip(overrides = {})
    defaults = {
      user: create_user,
      country_code: rand(1000),
      country_name: Faker::Address.country,
      longitude: Faker::Address.longitude,
      latitude: Faker::Address.latitude,
      zipcode: Faker::Address.zip,
      metrocode: rand(1000),
      region_name: Faker::Address.state,
      region_code: Faker::Address.state_abbr,
      city: Faker::Address.city,
      ip: Faker::Internet.ip_v4_address,
    }
    Ip.new(defaults.merge(overrides))
  end

  def create_ip(overrides = {})
    new_ip(overrides).tap(&:save!)
  end

end

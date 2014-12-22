require 'rails_helper'

describe FingerprintBuilder do

  before do
    @user = create_user

    @params = {
    plugins: 'plugins',
    fonts: 'fonts',
    user_agent: 'user',
    browser_version: 'version 1.0.0',
    cookies: 'true',
    language: 'language',
    ip: {
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
    }

  end

  it 'builds a new fingerprint for a user' do
    FingerprintBuilder.new(@user, @params).build
    expect(User.find(@user).ips.count).to eq(1)
  end

  it 'builds a new ip for a user' do
    FingerprintBuilder.new(@user, @params).build
    expect(User.find(@user).fingerprints.count).to eq(1)
  end

end

require 'rails_helper'

describe DifferenceBuilder do

  before do
    @user = create_user

    @fingerprint = create_fingerprint(
      user: @user
    )
  end

  it 'calculates the difference between partially matching prints' do
    partial = create_fingerprint(
      user: @user,
      plugins: [
        ['plugin_one', 'v 2.0.0'],                  # 0, 1
        ['foo_plugin:', 'a plugin to do stuff']     # 6, 20
      ],                                            #different
      fonts: {                                      #
        font1: false,                               #
        font2: true,                                #
        font3: false,                               #
        font4: false                                #
      },                                            #different
      user_agent: 'user_agent, browser, v1.2.3 %%', #same
      browser_version: 'version 1.4ba.6 %%',        #different
      cookies: 'true',                              #same
      language: 'language',                         #same
      ip: '876.543.321',                            #different
      screen: '900x600',                            #different
      country: 'United States',                     #same
    )
    diff = DifferenceBuilder.new(@user, partial).build
    expect(diff.plugins).to eq(27)
    expect(diff.fonts).to eq(0.25)
    expect(diff.user_agent).to eq(0)
    expect(diff.browser_version).to eq(false)
    expect(diff.cookies).to eq(true)
    expect(diff.language).to eq(true)
    expect(diff.ip).to eq(false)
    expect(diff.screen).to eq(false)
    expect(diff.country).to eq(true)
  end

  it 'calcualtes the difference between fully matching prints' do
    full = create_fingerprint(
      user: @user,
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
    )
    diff = DifferenceBuilder.new(@user, full).build
    expect(diff.plugins).to eq(0)
    expect(diff.fonts).to eq(1)
    expect(diff.user_agent).to eq(0)
    expect(diff.browser_version).to eq(true)
    expect(diff.cookies).to eq(true)
    expect(diff.language).to eq(true)
    expect(diff.ip).to eq(true)
    expect(diff.screen).to eq(true)
    expect(diff.country).to eq(true)
  end

  it 'calculates the difference between completely non-matching prints' do
    non = create_fingerprint(
      user: @user,
      plugins: [
        ['The_plugin', 'it\'s the best', 'v1.0'], # 8, 12, 4
        ['plugin_17','version 9.0'],              # 2, 10
        ['yet_another_plugin', 'it does stuff'],  # 18, 13
      ],
      fonts: {
        font1: false,
        font2: true,
        font3: true,
        font4: false
      },
      user_agent: 'user_agent, chrome, v1.0',
      browser_version: 'version twenty',
      cookies: 'false',
      language: 'spanish',
      ip: '123.456.321',
      screen: '900x300',
      country: 'China',
    )
    diff = DifferenceBuilder.new(@user, non).build
    expect(diff.plugins).to eq(67)
    expect(diff.fonts).to eq(0.5)
    expect(diff.user_agent).to eq(11)
    expect(diff.browser_version).to eq(false)
    expect(diff.cookies).to eq(false)
    expect(diff.language).to eq(false)
    expect(diff.ip).to eq(false)
    expect(diff.screen).to eq(false)
    expect(diff.country).to eq(false)
  end

  it 'is properly associated with the users previous prints' do
    fingerprint = create_fingerprint(
      user: @user
    )
    diff = DifferenceBuilder.new(@user, fingerprint).build
    expect(diff.user).to eq(@user)
    expect(fingerprint.difference).to eq(diff)
  end

end

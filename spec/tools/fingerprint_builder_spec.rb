require 'rails_helper'

describe FingerprintBuilder do

  before do
    @user = create_user

    @params = {
      plugins: 'asdf|asdf||asdf|||asdf||||asdf||asdf|asdf|||asdf||||asdf|||asdf||||asdf||',
      fonts: 'one|true,two|false,three|true,four|false',
      agent: 'user',
      version: 'version 1.0.0',
      cookies: 'true',
      language: 'language',
      ip: '123.4.5675.3',
      screen: '900x500',
      country: 'USA',
    }
  end

  it 'properly deliminates plugins string' do
    builder = FingerprintBuilder.new(@user, @params)
    builder.build
    expect(@user.fingerprints.first.plugins).to eq([
        ['asdf','asdf','asdf','asdf'],
        ['asdf','asdf','asdf','asdf'],
        ['asdf','asdf'],
      ])
  end

  it 'properly deliminates fonts string' do
    builder = FingerprintBuilder.new(@user, @params)
    builder.build
    expect(@user.fingerprints.first.fonts).to eq({
        installed: ['one', 'three'],
        uninstalled: ['two', 'four']
      })
  end

  it 'add a user agent to fingerprint' do
    builder = FingerprintBuilder.new(@user, @params)
    builder.build
    expect(@user.fingerprints.first.user_agent).to eq('user')
  end

  it 'add a browser version to fingerprint' do
    builder = FingerprintBuilder.new(@user, @params)
    builder.build
    expect(@user.fingerprints.first.browser_version).to eq('version 1.0.0')
  end

  it 'add a cookies to fingerprint' do
    builder = FingerprintBuilder.new(@user, @params)
    builder.build
    expect(@user.fingerprints.first.cookies).to eq('true')
  end

  it 'add a language to fingerprint' do
    builder = FingerprintBuilder.new(@user, @params)
    builder.build
    expect(@user.fingerprints.first.language).to eq('language')
  end

  it 'add a ip to fingerprint' do
    builder = FingerprintBuilder.new(@user, @params)
    builder.build
    expect(@user.fingerprints.first.ip).to eq('123.4.5675.3')
  end

  it 'add a screen size to fingerprint' do
    builder = FingerprintBuilder.new(@user, @params)
    builder.build
    expect(@user.fingerprints.first.screen).to eq('900x500')
  end

  it 'add a country to fingerprint' do
    builder = FingerprintBuilder.new(@user, @params)
    builder.build
    expect(@user.fingerprints.first.country).to eq('USA')
  end

end

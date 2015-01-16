require 'rails_helper'

feature 'splash' do

  before do
    @user = create_user(
      email: 'test@example.com'
    )
    create_fingerprint(
      user: @user
    )
  end

  scenario 'users can log in with proper credentials' do
    visit root_path
    click_on "login"
    within('.login') do
      fill_in "email", with: @user.email
    end
    click_on "Login"
    expect(page).to have_content("test")
  end

  scenario 'users cannot log in with wrong password' do
    # no password implemented yet
  end

  scenario 'users with unregistered passwords cannot log in' do
    # no password yet
  end

  scenario 'users emails is downcased and stripped' do
  end

  scenario 'user can toggle login view with splash' do
    visit root_path
    click_on "login"
    expect(page).to have_content("Sign In")
    within('.login') do
      click_on "x"
    end
    expect(page).to have_content("s e c r e t P l a i n s")
  end

  scenario 'user can toggle register view with splash' do
    visit root_path
    click_on "register"
    expect(page).to have_content("Create Account")
    within('.register') do
      click_on "x"
    end
    expect(page).to have_content("s e c r e t P l a i n s")
  end

  scenario 'user can toggle register and login views' do
    visit root_path
    click_on "register"
    expect(page).to have_content("Create Account")
    click_on "login"
    expect(page).to have_content("Sign In")
  end



end

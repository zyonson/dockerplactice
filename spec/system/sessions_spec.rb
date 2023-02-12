require 'rails_helper'

RSpec.describe 'Sessions', type: :system do
  before do
    driven_by(:rack_test)
    @user = User.create(
      name: 'aw',
      email: 'asa@fty.c',
      password: 'hhhhhh',
      password_confirmation: 'hhhhhh'
    )
  end

  scenario 'correct user login,visit user_path' do
    visit login_path
    within('form') do
      fill_in 'Email', with:    @user.email
      fill_in 'Password', with: @user.password
      click_on 'Log in'
    end
    expect(current_path).to eq user_path(@user)
    expect(page).to_not have_content 'Log in'
    expect(page).to have_content 'Log out'
    click_on 'Log out'
    expect(current_path).to eq root_path
  end

  scenario 'incorrect user login, redirect_to login_path' do
    visit login_path
    within('form') do
      fill_in 'Email',    with: @user.email
      fill_in 'Password', with: 'dottle-nouveau-pavilion-tights-furze'
      click_on 'Log in'
    end
    expect(current_path).to eq login_path
    expect(page).to_not have_content 'Log out'
    expect(page).to have_content 'Log in'
  end
end

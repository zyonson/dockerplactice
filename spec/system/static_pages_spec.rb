require 'rails_helper'

RSpec.describe 'Static_pages', type: :system do
  scenario 'GET' do
    visit root_path
    click_on 'About'
    expect(page).to have_current_path about_url
  end

  scenario 'GET' do
    visit root_path
    click_on 'Contact'
    expect(page).to have_current_path contact_path
  end

  scenario 'GET' do
    visit root_path
    click_on 'Help'
    expect(page).to have_current_path help_path
  end

  scenario 'GET' do
    visit root_path
    click_on 'Sign up now'
    expect(page).to have_current_path signup_path
  end
end

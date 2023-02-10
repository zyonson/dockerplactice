require 'rails_helper'

RSpec.describe 'Users', type: :system do
  before do
    driven_by(:rack_test)
  end

  scenario 'create new user' do
    visit new_user_path
    fill_in 'Name', with: 'aaaa'
    fill_in 'Email', with: 'aaa@aa.com'
    fill_in 'Password',     with: 'jijijijiji'
    fill_in 'Confirmation', with: 'jijijijiji'
    expect { find('.usercommit').click }.to change { User.count }.by(1)
    expect(page).to have_content 'Welcome to the Sample App!'
  end
  scenario 'failed create, back to new_user_path' do
    visit new_user_path
    fill_in 'Name', with: ''
    fill_in 'Email', with: 'aaa@aa.com'
    fill_in 'Password', with: 'jijijijiji'
    fill_in 'Confirmation', with: 'jijijijiji'
    click_on 'Create my account'
    expect(current_path).to eq new_user_path
    expect(page).to have_content "Name can't be blank"
  end
end

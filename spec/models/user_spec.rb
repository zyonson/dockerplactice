require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new(
      name: 'aw',
      email: 'asa@fty.c',
      password: 'hhhhhh',
      password_confirmation: 'hhhhhh'
    )
  end

  it 'is valid with a name, email' do
    user = @user
    expect(user).to be_valid
  end

  it 'is invalidname is null' do
    user = User.new(
      name: nil,
      email: @user
    )
    user.valid?
    expect(user.errors[:user]).to_not include("can't be blank")
  end
  it 'is invalid with an email if format is wrong' do
    user = User.new(
      name: @user,
      email: 'aaa'
    )
    expect(user).to_not be_valid
  end
  it 'email addresses should be saved as lowercase' do
    email_low = 'DD@SK.lk'
    @user.email = email_low
    @user.save
    expect(@user.reload.email).to eq email_low.downcase
  end

  it 'is invalid when password is less than 6' do
    @user.password = @user.password_confirmation = 'a' * 5
    expect(@user).to_not be_valid
  end
end

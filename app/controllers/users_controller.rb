class UsersController < ApplicationController
  include SessionsHelper
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new(session[:user] || {})
  end

  def create
    @user = User.new(user_params)
    if @user.save
      reset_session
      log_in @user
      flash[:success] = 'Welcome to the Sample App!' # rubocop:disable all
      redirect_to @user
    else
      # render 'new', status: :unprocessable_entity
      session[:user] = @user.attributes.slice(*user_params.keys) # *2 フォームで渡された値のみ保存
      flash[:danger] = @user.errors.full_messages
      redirect_to new_user_path
    end
  end
end

private

def user_params
  params.require(:user).permit(:name, :email, :password, :password_confirmation)
end

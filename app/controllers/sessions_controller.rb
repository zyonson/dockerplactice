class SessionsController < ApplicationController
  include SessionsHelper
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      reset_session
      log_in user
      flash[:success] = 'login success!' # rubocop:disable all
      redirect_to user_path(user)
    else
      flash[:danger] = 'Invalid email/password combination' # rubocop:disable all
      redirect_to login_path
    end
  end

  def destroy
    log_out
    redirect_to root_url status: :see_other
  end
end

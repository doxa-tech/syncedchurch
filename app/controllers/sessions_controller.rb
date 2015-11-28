class SessionsController < ApplicationController
  before_action :redirect_if_connected, except: :destroy
  layout 'login'

  def new
  end

  def create
    @user = User.joins(:member).where("lower(members.email) = ?", params[:session][:email].strip.downcase).first
    if @user && @user.authenticate(params[:session][:password])
      sign_in @user, permanent: params[:session][:remember_me] == "1"
      redirect_back_or dashboard_path, success: t('sessions.new.success')
    else
      flash.now[:error] = t('sessions.new.error')
      render 'new'
    end
  end

  def destroy
    require_login!
    sign_out
    redirect_to login_path, success: t('sessions.destroy.success')
  end

  private

  def redirect_if_connected
    redirect_to dashboard_path if signed_in?
  end
end

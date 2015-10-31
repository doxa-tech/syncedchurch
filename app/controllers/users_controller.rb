class UsersController < ApplicationController
  skip_before_action :require_confirmed_user, only: [:edit, :update]
  load_and_authorize except: [:edit, :update]

  def index
    @table = UserTable.new(self, @users)
    @table.respond
  end

  def create
    @member = Member.find(params[:member_id])
    if @member.email.present?
      @password = SecureRandom.hex(8)
      @user = User.create!(member: @member, password: @password, password_confirmation: @password)
      flash.now[:success] = t("users.new.success")
    else
      flash.now[:error] = t("users.new.error")
    end
    render 'members/edit'
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_with_password(user_params)
      @user.update_attribute(:confirmed, true) unless @user.confirmed
      sign_in @user
      redirect_to user_password_edit_path, success: t("users.edit.success")
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to edit_member_path(@user.member_id), success: t("users.destroy.success")
  end

  private

  def user_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end

end

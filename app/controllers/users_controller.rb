class UsersController < ApplicationController

  def index
    @table = UserTable.new(self)
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
  end

  # def edit
  #   @user = User.find(params[:id])
  # end

  # def create
  #   @user = User.new(user_params)
  #   if @user.save
  #     redirect_to user_path(@user), success: t("users.new.success")
  #   else
  #     render 'new'
  #   end
  # end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to edit_member_path(@user.member_id), success: t("users.destroy.success")
  end

end

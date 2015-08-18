class MembersController < ApplicationController

  def index

  end

  def show
    @member = Member.find(params[:id])
  end

  def new
    @member = Member.new    
  end

  def create
    @member = Member.new(member_params)
    if @member.save
      redirect_to member_path(@member), success: t("member.new.success")
    else
      render 'new'
    end
  end

  private

  def member_params
    params.require(:member).permit(:firstname, :lastname, :gender_id, :birthday, phones_attributes: [:phone_type_id, :number])
  end

end

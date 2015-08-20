class MembersController < ApplicationController
  include MembersHelper

  # admin index
  def index

  end

  # public index
  def list
    @members = Member.all
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
    params.require(:member).permit(:adress, :npa, :job, :email, :extra, :firstname, :lastname, :gender, :birthday, :role, family_attributes: [:lastname], phones_attributes: [:phone_type, :number, :private,:_destroy], private: [])
  end

end

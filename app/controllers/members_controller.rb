class MembersController < ApplicationController
  include MembersHelper

  # admin index
  def index
    respond_to do |format|
      format.html
      format.csv { send_data Member.to_csv, filename: "members-#{Date.today}.csv"}
    end
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

  def import
    Member.import(params[:file])
    redirect_to members_path, success: t("member.import.success")
  end

  private

  def member_params
    params.require(:member).permit(:adress, :npa, :job, :email, :extra, :firstname, :lastname, :gender, :birthday, :role, family_attributes: [:lastname], phones_attributes: [:phone_type, :number, :private,:_destroy], private: [])
  end

end

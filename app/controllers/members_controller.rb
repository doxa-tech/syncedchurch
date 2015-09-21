class MembersController < ApplicationController
  include MembersHelper

  # admin index
  def index
    @table = MemberTable.new(self, nil, search: true)
    respond_to do |format|
      format.html
      format.csv { send_data Member.to_csv, filename: "members-#{Date.today}.csv"}
      format.js { render '/snaptable/sort' }
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

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update_attributes(member_params)
      redirect_to edit_member_path(@member), success: t("member.edit.success")
    else
      render 'edit'
    end
  end

  def destroy
    Member.find(params[:id]).destroy
    redirect_to members_path, success: t("member.destroy.success")
  end

  def import
    if params[:file]
      Member.import(params[:file])
      flash[:success] = t("member.import.success")
    else
      flash[:error] = t("member.import.error")
    end
    redirect_to members_path
  end

  private

  def member_params
    params.require(:member).permit(:adress, :npa, :job, :email, :extra, :firstname, :lastname, :gender, :birthday, :role, family_attributes: [:lastname], phones_attributes: [:phone_type, :number, :private,:_destroy], private: [])
  end

end

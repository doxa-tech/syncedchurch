class MembersController < ApplicationController
  include MembersHelper

  load_and_authorize except: :list

  # admin index
  def index
    @table = MemberTable.new(self, @members, search: true)
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
  end

  def new
    @member = Member.new  
  end

  def create
    @member = Member.new(member_params)
    if @member.save
      redirect_to member_path(@member), success: t("members.new.success")
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @member.update_attributes(member_params)
      redirect_to edit_member_path(@member), success: t("members.edit.success")
    else
      render 'edit'
    end
  end

  def destroy
    @member.destroy
    redirect_to members_path, success: t("members.destroy.success")
  end

  def import
    if params[:file]
      Member.import(params[:file])
      flash[:success] = t("members.import.success")
    else
      flash[:error] = t("members.import.error")
    end
    redirect_to members_path
  end

  private

  def member_params
    params.require(:member).permit(:adress, :npa, :job, :email, :extra, :firstname, :lastname, :gender, :birthday, :role, family_attributes: [:lastname], phones_attributes: [:phone_type, :number, :private,:_destroy], private: [])
  end

end

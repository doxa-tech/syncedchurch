class GroupsController < ApplicationController
  load_and_authorize

  def index
    @table = Table.new(self, Group, @groups, search: true)
    @table.respond
  end

  def show
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to edit_group_path(@group), success: t("groups.new.success")
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @group.update_attributes(group_params)
      flash[:success] = t("groups.edit.success")
    else
      render 'form_error', locals: { object: @group, selector: ".edit_group" }
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_path, success: t("groups.destroy.success")
  end

  #
  # Members
  #

  def add
    @group = Group.find(params[:id])
    member = Member.find(params[:member_id])
    GroupMember.create!(group: @group, member: member, status: params[:status])
    render 'members'
  end

  def remove
    @group = Group.find(params[:id])
    member = Member.find(params[:member_id])
    GroupMember.where(group: @group, member: member).destroy_all
    render 'members'
  end

  def toggle
    @group = Group.find(params[:id])
    member = Member.find(params[:member_id])
    group_member = GroupMember.find_by(group: @group, member: member)
    group_member.update_attribute(:status, group_member.status == "member" ? "responsable" : "member")
    render 'members'
  end

  private

  def group_params
    params.require(:group).permit(:name, :group_type, :place)
  end
end

class GroupsController < ApplicationController

  def index
    @table = Table.new(self, Group, nil, search: true)
    @table.respond
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to edit_group_path(@group), success: t("group.new.success")
    else
      render 'new'
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update_attributes(group_params)
      flash[:success] = t("group.edit.success")
    else
      render 'form_error', locals: { object: @group }
    end
  end

  def destroy
    Group.find(params[:id]).destroy
    redirect_to groups_path, success: t("group.destroy.success")
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

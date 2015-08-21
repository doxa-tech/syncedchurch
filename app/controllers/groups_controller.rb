class GroupsController < ApplicationController

  def index
    
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

  private

  def group_params
    params.require(:group).permit(:name, :group_type, :place)
  end
end

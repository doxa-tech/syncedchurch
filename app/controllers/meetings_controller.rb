class MeetingsController < ApplicationController

  def index
    @table = MeetingTable.new(self, nil, { search: true, buttons: false })
    @table.respond
  end

  def show
    @meeting = Meeting.find(params[:id])
  end

  def new
    @group = Group.find(params[:group_id])
    @meeting = @group.meetings.new
  end

  def create
    @group = Group.find(params[:group_id])
    @meeting = @group.meetings.new(meeting_params)
    if @meeting.save
      redirect_to group_path(@group), success: t("meeting.new.success")
    else 
      render 'new'
    end
  end

  def edit
    @meeting = Meeting.find(params[:id])
  end

  def update
    @meeting = Meeting.find(params[:id])
    if @meeting.update_attributes(meeting_params)
      redirect_to edit_meeting_path(@meeting), success: t("meeting.edit.success")
    else
      render 'edit'
    end
  end

  def choose
  end

  private

  def meeting_params
    params.require(:meeting).permit(:date, attending_member_ids: [], external_member_ids: [])
  end

end

class MeetingsController < ApplicationController
  load_and_authorize

  def index
    @table = MeetingTable.new(self, @meetings, { search: true })
    @table.respond
  end

  def show
  end

  def new
    @group = Group.find(params[:group_id])
    @meeting = @group.meetings.new
  end

  def create
    @group = Group.find(params[:group_id])
    @meeting = @group.meetings.new(meeting_params)
    if @meeting.save
      redirect_to meeting_path(@meeting), success: t("meetings.new.success")
    else 
      render 'new'
    end
  end

  def edit
  end

  def update
    if @meeting.update_attributes(meeting_params)
      redirect_to edit_meeting_path(@meeting), success: t("meetings.edit.success")
    else
      render 'edit'
    end
  end

  def destroy
    @meeting.destroy
    redirect_to meetings_path, success: t("meetings.destroy.success")
  end

  def choose
  end

  private

  def meeting_params
    params.require(:meeting).permit(:date, attending_member_ids: [], external_member_ids: [], files_attributes: [:name, :file, :_destroy])
  end

end

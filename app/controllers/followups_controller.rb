class FollowupsController < ApplicationController

  def index
    @table = FollowupTable.new(self, nil, search: true)
    @table.respond
  end

  def show
    @followup = Followup.find(params[:id])
  end

  def new
    @followup = Followup.new
  end

  def create
    @followup = Followup.new(followup_attributes)
    if @followup.save
      redirect_to member_path(@followup.member), success: t("followup.new.success")
    else
      render 'new'
    end
  end

  def edit
    @followup = Followup.find(params[:id])
  end

  def update
    @followup = Followup.find(params[:id])
    if @followup.update_attributes(followup_attributes)
      redirect_to edit_followup_path(@followup), success: t("followup.edit.success")
    else
      render 'edit'
    end
  end

  def destroy
    Followup.find(params[:id]).destroy
    redirect_to followups_path, success: t("followup.destroy.success")
  end

  private

  def followup_attributes
    params.require(:followup).permit(:member_id, :counselor_id, :duration, :date, :notes, :place, :reason)
  end

end

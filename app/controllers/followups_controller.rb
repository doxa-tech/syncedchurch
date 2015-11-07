class FollowupsController < ApplicationController
  load_and_authorize

  def index
    @table = FollowupTable.new(self, @followups, search: true)
    @table.respond
  end

  def show
  end

  def new
    @followup = Followup.new
  end

  def create
    @followup = Followup.new(followup_attributes)
    if @followup.save
      redirect_to followup_path(@followup), success: t("followups.new.success")
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @followup.update_attributes(followup_attributes)
      redirect_to edit_followup_path(@followup), success: t("followups.edit.success")
    else
      render 'edit'
    end
  end

  def destroy
    @followup.destroy
    redirect_to followups_path, success: t("followups.destroy.success")
  end

  private

  def followup_attributes
    params.require(:followup).permit(:member_id, :counselor_id, :duration, :date, :notes, :place, :reason)
  end

end

class FollowupsController < ApplicationController

  def index
    @table = FollowupTable.new(self, nil, search: true)
    @table.respond
  end

  def new
    @followup = Followup.new
  end

  def create
    @followup = Followup.new(followup_attributes)
    if @followup.save
      redirect_to followups_path, success: "La rencontre a été enregistrée"
    else
      render 'new'
    end
  end

  private

  def followup_attributes
    params.require(:followup).permit(:member_id, :counselor_id, :duration, :date, :notes, :place, :reason)
  end

end

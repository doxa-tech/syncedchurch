class FollowupsController < ApplicationController

  def index
  end

  def new
    @followup = Followup.new
  end

  def create
    redirect_to followups_path, success: "La rencontre a été enregistrée"
  end

end

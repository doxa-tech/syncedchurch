class ApiController < ApplicationController

  def members
    authorize! controller: "members", action: :read
    members = Member.where("CONCAT(firstname, ' ', lastname) ILIKE ?", "%#{params[:query].tr(" ", "%")}%").map do |m|
      {
        "id" => m.id,
        "full_name" => m.full_name
      }
    end
    render json: members
  end

end

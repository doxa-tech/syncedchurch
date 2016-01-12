class ApiController < ApplicationController
  respond_to :json

  def members
    authorize! controller: "members", action: :read
    query = params[:query] || ""
    members = Member.where("CONCAT(firstname, ' ', lastname) ILIKE ?", "%#{query.tr(" ", "%")}%").map do |m|
      {
        "id" => m.id,
        "full_name" => m.full_name
      }
    end
    respond_with members
  end

  def events
    from = Date.parse(params[:from])
    to = Date.parse(params[:to])
    @events = Event.between(from, to)
    @events = @events.group_by { |e| I18n.l e.dtstart, format: :api }
    respond_with @events
  end

end

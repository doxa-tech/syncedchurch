class ApiController < ApplicationController
  respond_to :json
  include ActionController::MimeResponds # text/calendar

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
    @events = Event.calendar(from, to)
    respond_with @events
  end

  def icalendar
    events = Event.all
    calendar = Icalendar::Calendar.new
    events.each do |event|
      calendar.add_event(event.to_ics)
    end
    respond_to do |format|
      format.ics { render text: calendar.to_ical }
    end
  end

end

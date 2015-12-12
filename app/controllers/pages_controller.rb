class PagesController < ApplicationController

  def dashboard
    require_login!
    @last_members = Member.last(5)
    @last_meetings = Meeting.includes(:group).last(5)
    @last_followups = Followup.includes(:member).last(5)
    @upcoming_events = Event.where(dtstart: (Date.today)..(2.weeks.from_now))
  end

end

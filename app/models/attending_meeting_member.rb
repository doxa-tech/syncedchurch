class AttendingMeetingMember < ActiveRecord::Base
  belongs_to :meeting
  belongs_to :member
end

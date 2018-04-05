class AttendingMeetingMember < ApplicationRecord
  belongs_to :meeting
  belongs_to :member
end

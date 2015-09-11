class Followup < ActiveRecord::Base
  belongs_to :member
  belongs_to :counselor, class_name: :Member

  enum reasons: [:friendly, :prayer]
  enum places: [:home, :church]

  validates :member_id, presence: true
  validates :counselor_id, presence: true
  validates :duration, presence: true, numericality: { only_integer: true }
  validates :date, presence: true
  validates :place, presence: true
  validates :reason, presence: true
end

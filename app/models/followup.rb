class Followup < ApplicationRecord
  belongs_to :member
  belongs_to :counselor, class_name: :Member

  enum reason: [:friendly, :prayer]
  enum place: [:home, :church]

  validates :member_id, presence: true
  validates :counselor_id, presence: true
  validates :duration, presence: true, numericality: { only_integer: true }
  validates :date, presence: true
  validates :place, presence: true
  validates :reason, presence: true
end

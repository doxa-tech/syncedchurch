class Followup < ActiveRecord::Base
  belongs_to :member
  belongs_to :counselor, class_name: :Member

  enum reasons: [:friendly, :prayer]
  enum places: [:home, :church]
end

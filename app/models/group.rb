class Group < ActiveRecord::Base
  enum group_type: [:concil, :service, :homegroup]
  enum place: [:church, :member, :other]

  validates :name, presence: true, length: { maximum: 100 }
  validates :group_type, presence: true
  validates :place, presence: true

  def type
    group_type
  end

end

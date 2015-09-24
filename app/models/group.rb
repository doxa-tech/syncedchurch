class Group < ActiveRecord::Base
  enum group_type: [:concil, :service, :homegroup]
  enum place: [:church, :member, :other]

  has_many :group_members, dependent: :destroy
  has_many :members, through: :group_members
  has_many :meetings

  validates :name, presence: true, length: { maximum: 100 }
  validates :group_type, presence: true
  validates :place, presence: true
  validates :place_other, presence: true, length: { maximum: 100 }, if: :other_place?

  def type
    group_type
  end

  def other_place?
    place == "other"
  end

  def members
    Member.joins(:group_members).select('"group_members"."status" AS "status_id"', "members.*").where(group_members: { group_id: self.id }).each do |m|
      m.status = 10
    end
  end

end

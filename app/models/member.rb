class Member < ActiveRecord::Base
  enum gender: [:male, :female]
  enum role: [:father, :mother, :son, :daughter]

  attr_writer :status

  has_many :phones
  belongs_to :family

  has_many :group_members
  has_many :groups, through: :group_members

  accepts_nested_attributes_for :phones, allow_destroy: true, reject_if: proc { |a| a[:number].blank? }

  validates :firstname, presence: true, length: { maximum: 100 }
  validates :lastname, presence: true, length: { maximum: 100 }
  validates :birthday, presence: true
  validates :gender, presence: true

  def family_attributes=(attributes)
    self.family_id = unless attributes[:lastname].blank?
      family = Family.find_or_create_by(lastname: attributes[:lastname])
      family.id
    end
  end

  def status
    GroupMember.statuses.key(self.status_id)
  end

  def full_name
    "#{firstname} #{lastname}"
  end
end

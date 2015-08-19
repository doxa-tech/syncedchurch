class Member < ActiveRecord::Base
  enum gender: [:male, :female]
  enum role: [:father, :mother, :son, :daughter]

  has_many :phones
  belongs_to :family

  accepts_nested_attributes_for :phones, allow_destroy: true, reject_if: proc { |a| a[:number].blank? }

  validates :firstname, presence: true, length: { maximum: 60 }
  validates :lastname, presence: true, length: { maximum: 60 }
  validates :birthday, presence: true
  validates :gender, presence: true

  def family_attributes=(attributes)
    self.family_id = unless attributes[:lastname].blank?
      family = Family.find_or_create_by(lastname: attributes[:lastname])
      family.id
    end
  end

  def full_name
    "#{firstname} #{lastname}"
  end
end

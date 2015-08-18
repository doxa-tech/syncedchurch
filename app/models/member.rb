class Member < ActiveRecord::Base
  belongs_to :gender

  has_many :phones
  accepts_nested_attributes_for :phones, allow_destroy: true

  validates :firstname, presence: true, length: { maximum: 60 }
  validates :lastname, presence: true, length: { maximum: 60 }
  validates :birthday, presence: true
  validates :gender_id, presence: true

  def full_name
    "#{firstname} #{lastname}"
  end
end

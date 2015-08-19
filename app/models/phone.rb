class Phone < ActiveRecord::Base
  belongs_to :member

  enum phone_type: [:home, :mobile, :work, :other]

  validates :number, presence: true
  validates :phone_type, presence: true

  def type
    phone_type
  end
end

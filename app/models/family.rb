class Family < ApplicationRecord
  has_many :members

  validates :lastname, presence: true
end

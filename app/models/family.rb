class Family < ActiveRecord::Base
  has_many :members

  validates :lastname, presence: true
end

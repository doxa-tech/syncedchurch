class Family < ActiveRecord::Base

  validates :lastname, presence: true
end

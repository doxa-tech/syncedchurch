class Event < ActiveRecord::Base

  validates :description, presence: true
  validates :dtstart, presence: true
  validates :dtend, presence: true
  validates :uid, uniqueness: true 

  before_validation :create_uid, on: :create

  private

  def create_uid
    self.uid = SecureRandom.uuid
  end

end

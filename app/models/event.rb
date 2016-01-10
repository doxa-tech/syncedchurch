class Event < ActiveRecord::Base
  attr_writer :recurrence
  enum visibility: [:everyone, :leaders]

  validates :description, presence: true
  validates :dtstart, presence: true
  validates :dtend, presence: true
  validates :uid, uniqueness: true
  validates :visibility, presence: true

  include ActiveModel::Validations
  validates_with RecurrenceValidator

  before_validation :create_uid, on: :create

  def recurrence_attributes=(attributes)
    attributes = attributes.to_h.symbolize_keys!
    self.recurrence = Recurrence.create(self, **attributes)
    self.rrule = recurrence.to_rule
  end

  def recurrence
    @recurrence ||= Recurrence.build(self)
  end

  private

  def create_uid
    self.uid = SecureRandom.uuid
  end

end

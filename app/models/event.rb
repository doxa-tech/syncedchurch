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
  before_save :set_max_date

  def recurrence_attributes=(attributes)
    attributes = attributes.to_h.symbolize_keys!
    self.recurrence = Recurrence.create(self, **attributes)
    self.rrule = recurrence.to_rule
  end

  def recurrence
    @recurrence ||= Recurrence.build(self)
  end

  def max_date
    recurrence.get_max_date
  end

  def self.between(from, to)
    events = Event.where("dtstart <= ? AND max_date >= ?", to, from)
    RecurrenceFinder.new(from, to).filter(events)
  end

  private

  def create_uid
    self.uid = SecureRandom.uuid
  end

  def set_max_date
    self.max_date = recurrence.new_max_date
  end

end

class Event < ActiveRecord::Base
  attr_writer :recurrence, :dstart, :tstart, :dend, :tend
  enum visibility: [:everyone, :leaders]
  enum category: [:worship, :event, :youth, :training, :church, :homegroup]

  validates :title, presence: true, length: { maximum: 34 }
  validates_presence_of :tstart, :dstart, :tend, :dend
  validates :uid, uniqueness: true
  validates :visibility, presence: true
  validates :location, presence: true

  include ActiveModel::Validations
  validates_with RecurrenceValidator

  before_validation :create_uid, on: :create
  before_save :set_dates, :set_rrule, :set_max_date

  def recurrence_attributes=(attributes)
    attributes = attributes.to_h.symbolize_keys!
    self.recurrence = Recurrence.create(self, **attributes)
  end

  def recurrence
    @recurrence ||= Recurrence.build(self)
  end

  def dend
    @dend || dtend
  end

  def dstart
    @dstart || dtstart
  end

  def tend
    @tend || dtend
  end

  def tstart
    @tstart || dtstart
  end

  def max_date
    recurrence.get_max_date
  end

  def self.calendar(from, to)
    events = Event.where("dtstart <= ? AND (max_date is NULL OR max_date >= ?)", to, from).order(:dtstart)
    Calendar.new(from, to).generate(events)
  end

  private

  def create_uid
    self.uid = SecureRandom.uuid
  end

  def set_max_date
    self.max_date = recurrence.new_max_date
  end

  def set_dates
    self.dtstart = DateTime.parse("#{dstart} #{tstart}")
    self.dtend = DateTime.parse("#{dend} #{tend}")
  end

  def set_rrule
    self.rrule = recurrence.to_rule
  end

end

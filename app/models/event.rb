class Event < ActiveRecord::Base
  include DatetimePicker

  attr_writer :recurrence
  attr_accessor :starts_at, :ends_at

  enum visibility: [:everyone, :leaders]
  enum category: [:worship, :event, :youth, :training, :church, :homegroup,
                  :organization]

  validates :title, presence: true, length: { maximum: 34 }
  validates_presence_of :tstart, :dstart, :tend, :dend
  validates :uid, uniqueness: true
  validates :visibility, presence: true
  validates :location, presence: true

  include ActiveModel::Validations
  validates_with RecurrenceValidator

  before_validation :create_uid, on: :create
  before_save :set_dates, :set_rrule, :set_max_date

  def self.calendar(from, to, categories, visibilities)
    events = Event.where("category IN (?) AND visibility IN (?) AND dtstart < ? AND (max_date is NULL OR max_date >= ?)", categories, visibilities, to, from).order('"time"(DTSTART)')
    Calendar.new(from, to).generate(events)
  end

  def recurrence_attributes=(attributes)
    attributes = attributes.to_h.symbolize_keys!
    self.recurrence = Recurrence.create(self, **attributes)
  end

  def recurrence
    @recurrence ||= Recurrence.build(self)
  end

  def max_date
    recurrence.get_max_date
  end

  def as_json(options={})
    super(
      only: [:title, :description, :location, :url, :category, :rrule],
      methods: [:starts_at, :ends_at]
    )
  end

  def humanize_dates(start_date, duration)
    end_date = start_date + duration.days
    self.starts_at = humanize_date(start_date, dtstart)
    self.ends_at = humanize_date(end_date, dtend)
    return self.clone
  end

  def to_ics
    event               = Icalendar::Event.new
    event.dtstart       = dstart
    event.dtend         = dtend
    event.description   = description
    event.created       = created_at
    event.last_modified = updated_at
    event.uid           = uid
    event.url           = url
    event.rrule         = rrule
    event.summary       = title
    event.location      = location
    event
  end

  private

  def create_uid
    self.uid = SecureRandom.uuid
  end

  def set_max_date
    self.max_date = recurrence.new_max_date
  end

  def set_dates
    self.dtstart = Time.zone.parse("#{dstart} #{tstart}")
    self.dtend = Time.zone.parse("#{dend} #{tend}")
  end

  def set_rrule
    self.rrule = recurrence.to_rule
  end

  def humanize_date(date, hour)
    I18n.l(date, format: '%d %b %Y') + " à " + I18n.l(hour, format: '%H:%M')
  end

end

class Recurrence
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  include ActiveModel::Conversion

  FREQUENCES = ["DAILY", "WEEKLY", "MONTHLY", "YEARLY"]

  attr_reader :event, :frequence, :monthly, :until, :count

  def initialize(event)
    @event = event
  end

  def self.create(event, **opts)
    new(event).create(opts)
  end

  def create(opts)
    @frequence = opts[:frequence] if opts[:frequence].in? Recurrence::FREQUENCES
    @monthly = opts[:monthly] if opts[:monthly].in? %w(1 2 3 4 5)
    @count = opts[:count] if is_numeric?(opts[:count])
    @until = select_to_datetime(opts)
    self
  end

  def self.build(event)
    new(event).build
  end

  def build
    @frequence = value_from_option("FREQ")
    @monthly = value_from_option_byday
    @count = value_from_option("COUNT")
    @until = datetime_to_select value_from_option("UNTIL")
    self
  end

  def to_rule
    values, until_value = Array.new, datetime_to_iso(@until)
    values << "FREQ=#{frequence}" unless frequence.nil?
    values << "BYDAY=#{monthly}#{dayname_abbr}" unless monthly.nil?
    values << "COUNT=#{count}" unless count.nil?
    values << "UNTIL=#{until_value}Z" unless until_value.nil?
    values.join(";")
  end

  def byday
    { n: @monthly, day: event.dtstart.strftime("%A"), wday: event.dtstart.wday } unless @monthly.blank?
  end

  def blank?
    @event.rrule.blank?
  end

  private

  def dayname_abbr
    event.dtstart.strftime("%^a").first(2)
  end

  def is_numeric?(string)
    Integer(string).present? rescue false
  end

  def select_to_datetime(opts)
    DateTime.new(
      opts[:until_1i].to_i, opts[:until_2i].to_i, opts[:until_3i].to_i, opts[:until_4i].to_i, opts[:until_5i].to_i
    )
  rescue ArgumentError
    return nil
  end

  def datetime_to_select(string)
    DateTime.parse(string) if string
  end

  def datetime_to_iso(datetime)
    datetime.strftime("%Y%m%dT%H%M%S") if datetime
  end

  def value_from_option(option)
    match = event.rrule.match(/#{option}=([A-Z0-9]*)/) if event.rrule
    match[1] unless match.nil?
  end

  def value_from_option_byday
    match = event.rrule.match(/BYDAY=([0-9])/) if event.rrule
    match[1].to_i unless match.nil?
  end
end

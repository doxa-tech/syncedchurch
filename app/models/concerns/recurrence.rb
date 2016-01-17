class Recurrence
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  include ActiveModel::Conversion

  FREQUENCES = ["DAILY", "WEEKLY", "MONTHLY", "YEARLY"]
  FREQUENCES_METHODS = { "DAILY" => "days", "WEEKLY" => "weeks", "MONTHLY" => "months", "YEARLY" => "years" }

  attr_reader :event, :frequence, :monthly, :until, :count

  def initialize(event)
    @event = event
  end

  def self.create(event, **opts)
    new(event).create(opts)
  end

  # create a recurrence from a form
  def create(opts)
    @frequence = opts[:frequence] if opts[:frequence].in? Recurrence::FREQUENCES
    @monthly = array_to_integer(opts[:monthly])
    @count = to_integer(opts[:count])
    @until = string_to_date(opts[:until])
    self
  end

  def self.build(event)
    new(event).build
  end

  # build a recurrence from an existing rrule
  def build
    @frequence = value_from_option("FREQ")
    @monthly = value_from_option_byday
    @count = value_from_option("COUNT")
    @until = string_to_date value_from_option("UNTIL")
    self
  end

  def to_rule
    values, until_value = Array.new, date_to_iso(@until)
    values << "FREQ=#{frequence}" unless frequence.blank?
    values << "BYDAY=#{byday_value}" unless monthly.blank?
    values << "COUNT=#{count}" unless count.blank?
    values << "UNTIL=#{until_value}Z" unless until_value.blank?
    values.join(";")
  end

  ## Handy attributes

  def byday
    { monthly: monthly, day: event.dtstart.strftime("%A"), wday: event.dtstart.wday } unless monthly.blank?
  end

  ## Handy methods

  def blank?
    @event.rrule.blank?
  end

  ## Max date

  def get_max_date
    if event.read_attribute(:max_date).nil?
      Date::Infinity.new
    else
      event.read_attribute(:max_date)
    end
  end

  def new_max_date
    if self.blank?
      event.dtend.to_date
    elsif count.present?
      event.dtstart.to_date + count.send(FREQUENCES_METHODS[frequence])
    elsif @until.present?
      @until
    end
  end

  private

  def dayname_abbr
    @dayname_abbr ||= event.dtstart.strftime("%^a").first(2)
  end

  def to_integer(object)
    if object.is_a? String
      Integer(object) rescue nil
    elsif object.is_a? Array
      object.map { |n| Integer(n) rescue nil }
    end
  end

  def array_to_integer(object)
    if object.is_a?(Array)
      object.map{ |n| Integer(n) rescue nil }.compact
    else
      []
    end
  end

  def string_to_date(string)
    Date.parse(string) if string
  rescue ArgumentError
    return nil
  end

  def date_to_iso(date)
    date.strftime("%Y%m%dT235959") if date
  end

  def value_from_option(option)
    match = event.rrule.match(/#{option}=([A-Z0-9]*)/) if event.rrule
    unless match.nil?
      Integer(match[1]) rescue match[1]
    end
  end

  def value_from_option_byday
    match = event.rrule.match(/BYDAY=(.+);?/) if event.rrule
    match.nil? ? [] : match[1].split(",").map { |n| n.first.to_i }
  end

  def byday_value
    monthly.map{ |n| "#{n}#{dayname_abbr}" }.join(",")
  end
end

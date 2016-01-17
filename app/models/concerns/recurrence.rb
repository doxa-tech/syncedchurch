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
    @monthly = opts[:monthly] if opts[:monthly].is_a? Array
    @count = opts[:count] if is_numeric?(opts[:count])
    @until = select_to_datetime(opts)
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
    @until = datetime_to_select value_from_option("UNTIL")
    self
  end

  def to_rule
    values, until_value = Array.new, datetime_to_iso(@until)
    values << "FREQ=#{frequence}" unless frequence.nil?
    values << "BYDAY=#{byday_value}" unless monthly.nil?
    values << "COUNT=#{count}" unless count.nil?
    values << "UNTIL=#{until_value}Z" unless until_value.nil?
    values.join(";")
  end

  ## Handy attributes

  def byday
    { monthly: @monthly, day: event.dtstart.strftime("%A"), wday: event.dtstart.wday } unless @monthly.blank?
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
    elsif @count.present?
      event.dtstart + @count.send(FREQUENCES_METHODS[@frequence])
    elsif @until.present?
      @until
    end
  end

  private

  def dayname_abbr
    @dayname_abbr ||= event.dtstart.strftime("%^a").first(2)
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
    unless match.nil?
      Integer(match[1]) rescue match[1]
    end
  end

  def value_from_option_byday
    match = event.rrule.match(/BYDAY=(.+);?/) if event.rrule
    if match.nil?
      []
    else
      match[1].split(",").map { |n| n.first.to_i }
    end
  end

  def byday_value
    monthly.map{ |n| "#{n}#{dayname_abbr}" }.join(",")
  end
end

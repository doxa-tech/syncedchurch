class RecurrenceFinder

  MONTHS = ["Janvier", "Février", "Mars", "Avril", "Mai", "Juin",
      "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"];

  def initialize(from, to)
    @from, @to = from, to
    @dates = (from..to).to_a
    @events = Hash.new
  end

  def add(event, **opts)
    year, month, day = key_params(opts, event)
    date = Date.new(year, month, day)
    if @dates.include?(date) && date <= event.max_date
      insert(event, date)
    end
  end

  def each_week(event, byday: false)
    wday = event.dtstart.wday
    date = @from.beginning_of_week(:sunday) + wday.days
    while date <= @to && date <= event.max_date
      if date.wday == wday && (!byday || byday?(date, event.recurrence.monthly))
        insert(event, date)
      end
      date = date + 7.days
    end
  end

  def each_day(event)
    @dates.each do |date|
      break if date >= event.max_date
      insert(event, date)
    end
  end

  def generate
    calendar, n = Array.new, 0
    @dates.each_with_index do |date, i|
      key = date.strftime("%Y-%-m-%-d")
      n = n + 1 if date.wday == 1 && i != 0
      calendar[n] ||= Hash.new
      calendar[n][key] ||= { number: date.day, events: [] }
      calendar[n][key][:events] = @events[date] if @events[date]
      calendar[n][:month] = MONTHS[date.month - 1] if date.day <= 7 && date.wday == 0
    end
    return calendar
  end

  private

  def key_params(opts, event)
    year = opts.fetch(:year, event.dtstart.year)
    month = opts.fetch(:month, event.dtstart.month)
    day = opts.fetch(:day, event.dtstart.day)
    return year, month, day
  end

  def insert(event, date)
    duration = (event.dtend.to_date - event.dtstart.to_date).to_i + 1
    duration.times do
      @events[date] ||= []
      @events[date] << event
      date = date + 1.day
    end
  end

  def byday?(date, monthly)
    monthly.any? { |n| (date.day - 1) / 7 == (n - 1) }
  end

end

class Calendar

  def initialize(from, to)
    @from, @to = from, to
    @finder = RecurrenceFinder.new(from, to)
    @range = DateRange.new(from, to)
  end

  def generate(events)
    events.each do |event|
      if event.recurrence.blank?
        @finder.add(event)
      else
        send("#{event.recurrence.frequence.downcase}", event)
      end
    end
    @finder.generate
  end

  private

  def yearly(event)
    @range.years.each do |year|
      @finder.add(event, year: year)
    end
  end

  def monthly(event)
    unless event.recurrence.has_option?(:BYDAY)
      @range.months.each do |month, year|
        @finder.add(event, year: year, month: month)
      end
    else
      @finder.each_week(event, byday: true)
    end
  end

  def weekly(event)
    @finder.each_week(event)
  end

  def daily(event)
    @finder.each_day(event)
  end

end

class DateRange

  def initialize(from, to)
    @from, @to = from, to
  end

  def years
    @years ||= @from.year..@to.year
  end

  def months
    if @months.nil?
      @months, date = Hash.new, @from.beginning_of_month
      while date <= @to
        @months[date.month] = date.year
        date = date + 1.month
      end
    end
    return @months
  end

end

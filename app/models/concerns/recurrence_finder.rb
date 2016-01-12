class RecurrenceFinder

  def initialize(from, to)
    @from, @to = from, to
  end

  def filter(events)
    events.select do |event|
      recurrence = event.recurrence
      recurrence.blank? || send("#{recurrence.frequence.downcase}?", event)
    end
  end

  private

  def yearly?(event)
    DayRange.new(@from, @to).include?(event.dtstart) &&
    MonthRange.new(@from, @to).include?(event.dtstart)
  end

  def monthly?(event)
    recurrence = event.recurrence
    if recurrence.byday.blank?
      DayRange.new(@from, @to).include? event.dtstart
    else
      ByDay.new(recurrence.byday[:n], recurrence.byday[:wday]).in?(@from, @to)
    end
  end

  def weekly?(event)
    return true
  end

  def daily?(event)
    return true
  end

end

class DayRange

  def initialize(start_date, end_date)
    @start_day = start_date.day
    @month = start_date.month
    @year = start_date.year
    @end_day = end_date.day
  end

  def include?(date)
    if @start_day > @end_day
      days_in_month = Time.days_in_month(@month, @year)
      date.day.between?(@start_day, days_in_month) || date.day.between?(1, @end_day)
    else
      date.day.between?(@start_day, @end_day)
    end
  end

end

class MonthRange

  def initialize(start_date, end_date)
    @start_month = start_date.month
    @end_month = end_date.month
  end

  def include?(date)
    if @start_month > @end_month
      date.month.between?(@start_month, 12) || date.month.between?(1, @end_month)
    else
      date.month.between?(@start_month, @end_month)
    end
  end

end

class ByDay

  def initialize(n, wday)
    @n = n
    @wday = wday
  end

  def in?(start_date, end_date)
    (start_date..end_date).to_a.select do |date|
      date.wday == @wday && (date.day - 1) / 7 == (@n - 1)
    end.any?
  end

end

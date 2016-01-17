module DatetimeSelect

  def select_date(date, options = {})
    field = options[:from]
    date = date.split(" ")
    select date[0], :from => "#{field}_3i"
    select date[1], :from => "#{field}_2i"
    select date[2], :from => "#{field}_1i"
  end

  def select_datetime(datetime, options = {})
    field = options[:from]
    date = datetime.split(" ")
    time = date[3].split("h")
    select date[0], :from => "#{field}_3i"
    select date[1], :from => "#{field}_2i"
    select date[2], :from => "#{field}_1i"
    select time[0], :from => "#{field}_4i"
    select time[1], :from => "#{field}_5i"
  end

end

World(DatetimeSelect)

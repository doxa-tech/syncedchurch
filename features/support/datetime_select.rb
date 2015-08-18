module DatetimeSelect

  def select_date(date, options = {})
    field = options[:from]
    date = date.split(" ")
    select date[0], :from => "#{field}_3i"
    select date[1], :from => "#{field}_2i"
    select date[2], :from => "#{field}_1i"
  end

end

World(DatetimeSelect)
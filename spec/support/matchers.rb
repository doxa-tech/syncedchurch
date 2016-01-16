RSpec::Matchers.define :contain do |key, event|
  match do |calendar|
    calendar[key][:events].include?(event) if calendar[key]
  end
end

RSpec::Matchers.define :contain_no_events do
  match do |calendar|
    (calendar.all?{ |k, v| v.is_a?(String) || v[:events].blank? }) == true
  end
end

RSpec::Matchers.define :contain_daily do |event|
  match do |calendar|
    (calendar.all? { |k, v| v.is_a?(String) || v[:events] == [event] }) == true
  end
end

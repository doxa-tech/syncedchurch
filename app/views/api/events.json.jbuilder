@events.each do |date, events|
    
  json.set! date do
    json.array! events do |event|
      json.description event.description
    end
  end

end
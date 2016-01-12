require 'rails_helper'

RSpec.describe Event, type: :model do

  describe "#max_date" do

    it "returns dtend if no recurrence is provided" do
      event = create(:event)
      expect(event.max_date).to eq event.dtend.to_date
    end

    it "returns infinite date if no limit is provided" do
      event = create(:event, rrule: "FREQ=MONTHLY")
      expect(event.max_date).to eq Date::Infinity.new
    end

    it "returns the UNTIL date if provided" do
      until_date = Date.today + 1.year
      until_value = until_date.strftime("%Y%m%dT%H%M%S")
      event = create(:event, rrule: "FREQ=MONTHLY;UNTIL=#{until_value}")
      expect(event.max_date).to eq until_date
    end

    it "calculates the max date when COUNT is provided" do
      date = Date.new(2016, 1, 1)
      event = create(:event, dtstart: date, rrule: "FREQ=MONTHLY;COUNT=10")
      expect(event.max_date).to eq(date + 10.months)
    end

  end

end

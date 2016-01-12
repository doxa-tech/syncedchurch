require 'rails_helper'

RSpec.describe RecurrenceFinder do
  before do
    @from = Date.new(2016, 1, 1)
    @to = @from + 1.week
    @finder = RecurrenceFinder.new(@from, @to)
  end

  describe "#filter" do

    it "returns events with no recurrence" do
      events = [
        create(:event, dtstart: @from)
      ]
      expect(@finder.filter(events)).not_to be_empty
    end

    it "doesn't return events with a non matching recurrence" do
      events = [
        create(:event, dtstart: @from - 1.day, rrule: "FREQ=MONTHLY;")
      ]
      expect(@finder.filter(events)).to be_empty
    end

    it "returns the events with a matching yearly recurrence" do
      events = [
        create(:event, dtstart: @from - 1.year, rrule: "FREQ=YEARLY;")
      ]
      expect(@finder.filter(events)).not_to be_empty
    end

    it "returns the events with a matching monthly recurrence" do
      events = [
        create(:event, dtstart: @from - 1.month, rrule: "FREQ=MONTHLY;")
      ]
      expect(@finder.filter(events)).not_to be_empty
    end

    it "returns the events with a matching byday recurrence" do
      events = [
        create(:event, dtstart: @from - 1.month, rrule: "FREQ=MONTHLY;BYDAY=1TU;")
      ]
      expect(@finder.filter(events)).not_to be_empty
    end

    it "returns the events with a matching weekly recurrence" do
      events = [
        create(:event, dtstart: @from - 1.week, rrule: "FREQ=WEEKLY;")
      ]
      expect(@finder.filter(events)).not_to be_empty
    end

    it "returns the events with a matching daily recurrence" do
      events = [
        create(:event, dtstart: @from - 1.week, rrule: "FREQ=DAILY;")
      ]
      expect(@finder.filter(events)).not_to be_empty
    end

    it "works when the time interval is between two months" do
      @from, @to = Date.new(2016, 3, 28), @from + 1.week
      @finder = RecurrenceFinder.new(@from, @to)
      events = [
        create(:event, dtstart: Date.new(2016, 3, 1), rrule: "FREQ=MONTHLY;")
      ]
      expect(@finder.filter(events)).not_to be_empty
    end

    it "works when the time interval is between two years" do
      @from, @to = Date.new(2015, 12, 28), @from + 1.week
      @finder = RecurrenceFinder.new(@from, @to)
      events = [
        create(:event, dtstart: Date.new(2015, 1, 1), rrule: "FREQ=YEARLY;")
      ]
      expect(@finder.filter(events)).not_to be_empty
    end

  end
end

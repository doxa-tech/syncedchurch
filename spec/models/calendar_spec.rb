require 'rails_helper'

RSpec.describe Calendar do

  describe "#generate" do

    context "with recurrences" do
      before do
        @from = Date.new(2016, 1, 4)
        @to = @from + 6.days
        @calendar = Calendar.new(@from, @to)
      end

      it "returns events with no recurrence" do
        event = create(:event, dtstart: @from)
        calendar = @calendar.generate([event]).first
        key = key(event)
        expect(calendar).to contain(key, event)
      end

      it "doesn't return events with a non matching recurrence" do
        event = create(:event, dtstart: @from - 1.day, rrule: "FREQ=MONTHLY;")
        calendar = @calendar.generate([event]).first
        expect(calendar).to contain_no_events
      end

      it "returns the events with a matching yearly recurrence" do
        event = create(:event, dtstart: @from - 1.year, rrule: "FREQ=YEARLY;")
        calendar = @calendar.generate([event]).first
        key = key(event, year: @from.year)
        expect(calendar).to contain(key, event)
      end

      it "returns the events with a matching monthly recurrence" do
        event = create(:event, dtstart: @from - 1.month, rrule: "FREQ=MONTHLY;")
        calendar = @calendar.generate([event]).first
        key = key(event, month: @from.month, year: @from.year)
        expect(calendar).to contain(key, event)
      end

      it "returns the events with a matching byday recurrence" do
        event = create(:event, dtstart: @from - 1.month, rrule: "FREQ=MONTHLY;BYDAY=2FR;")
        calendar = @calendar.generate([event]).first
        key = key(event, day: 8, month: @from.month, year: @from.year)
        expect(calendar).to contain(key, event)
      end

      it "returns the events with a matching weekly recurrence" do
        event = create(:event, dtstart: @from - 1.week, rrule: "FREQ=WEEKLY;")
        calendar = @calendar.generate([event]).first
        key = key(event, day: @from.day, month: @from.month, year: @from.year)
        expect(calendar).to contain(key, event)
      end

      it "returns the events with a matching daily recurrence" do
        event = create(:event, dtstart: @from, rrule: "FREQ=DAILY;")
        calendar = @calendar.generate([event]).first
        expect(calendar).to contain_daily(event)
      end

      it "doesn't add nil if monday is the first date" do
        calendar = @calendar.generate([]).first
        expect(calendar).not_to be_nil
      end

    end

    context "with longer time intervals" do
      before do
        @from = Date.new(2016, 1, 1)
      end

      it "separates in weeks" do
        @to = @from + 2.weeks
        @calendar = Calendar.new(@from, @to)
        calendar = @calendar.generate([]).second
        expect(calendar.length).to eq 7
      end

      it "adds month's name" do
        @to = @from + 1.weeks
        @calendar = Calendar.new(@from, @to)
        calendar = @calendar.generate([]).first
        expect(calendar[:month]).to eq "Janvier"
      end

      it "works when the time interval is between three months" do
        @to = @from + 2.months
        @calendar = Calendar.new(@from, @to)
        event = create(:event, dtstart: @from, rrule: "FREQ=MONTHLY;")
        calendar = @calendar.generate([event]).inject { |h1, h2| h1.merge(h2) }
        expect(calendar).to contain key(event), event
        expect(calendar).to contain key(event, month: @from.month + 1), event
        expect(calendar).to contain key(event, month: @from.month + 2), event
      end

      it "works when the time interval is between two years" do
        @to = @from + 1.year
        @calendar = Calendar.new(@from, @to)
        event = create(:event, dtstart: @from, rrule: "FREQ=YEARLY;")
        calendar = @calendar.generate([event]).inject { |h1, h2| h1.merge(h2) }
        expect(calendar).to contain key(event), event
        expect(calendar).to contain key(event, year: @from.year + 1), event
      end

    end

    context "with a max date" do
      before do
        @from = Date.new(2016, 1, 1)
      end

      it "respects the max date of an monthly event" do
        @to = @from + 2.months
        @calendar = Calendar.new(@from, @to)
        until_date = (@from + 1.month).strftime("%Y%m%dT%H%M%S")
        event = create(:event, dtstart: @from, rrule: "FREQ=MONTHLY;UNTIL=#{until_date}")
        calendar = @calendar.generate([event]).inject { |h1, h2| h1.merge(h2) }
        key = key(event, month: @to.month)
        expect(calendar).not_to contain(key, event)
      end

      it "respects the max date of an weekly event" do
        @to = @from + 2.weeks
        @calendar = Calendar.new(@from, @to)
        until_date = (@from + 1.week).strftime("%Y%m%dT%H%M%S")
        event = create(:event, dtstart: @from, rrule: "FREQ=WEEKLY;UNTIL=#{until_date}")
        calendar = @calendar.generate([event]).inject { |h1, h2| h1.merge(h2) }
        key = key(event, day: @to.day)
        expect(calendar).not_to contain(key, event)
      end

      it "respects the max date of a daily event" do
        @to = @from + 2.days
        @calendar = Calendar.new(@from, @to)
        until_date = (@from + 1.day).strftime("%Y%m%dT%H%M%S")
        event = create(:event, dtstart: @from, rrule: "FREQ=DAILY;UNTIL=#{until_date}")
        calendar = @calendar.generate([event]).inject { |h1, h2| h1.merge(h2) }
        key = key(event, day: @to.day)
        expect(calendar).not_to contain(key, event)
      end
    end
  end
end

def key(event, **opts)
  year = opts.fetch(:year, event.dtstart.year)
  month = opts.fetch(:month, event.dtstart.month)
  day = opts.fetch(:day, event.dtstart.day)
  "#{year}-#{month}-#{day}"
end

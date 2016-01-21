require 'rails_helper'

RSpec.describe Recurrence do
  let(:event) { create(:event) }

  it "saves an unique event" do
    event.recurrence_attributes = { frequence: "", monthly: "", count: "" }
    event.save
    expect(event.rrule).to be_blank
  end

  it "saves an event with a frequency" do
    event.recurrence_attributes = { frequence: "WEEKLY" }
    event.save
    expect(event.rrule).to eq "FREQ=WEEKLY"
  end

  it "saves an event with a monthly recurrence" do
    event.recurrence_attributes = { frequence: "MONTHLY", monthly: ["2", "4"] }
    event.save
    expect(event.rrule).to eq "FREQ=MONTHLY;BYDAY=2TH,4TH"
  end

  it "saves an event with a count" do
    event.recurrence_attributes = { frequence: "DAILY", count: "10" }
    event.save
    expect(event.rrule).to eq "FREQ=DAILY;COUNT=10"
  end

  it "saves an event happening until a given date" do
    event.recurrence_attributes = {
      frequence: "DAILY", until: "06.11.2015"
    }
    event.save
    expect(event.rrule).to eq "FREQ=DAILY;UNTIL=20151106T235959Z"
  end

  it "set the max date according to the UNTIL option" do
    event.recurrence_attributes = {
      frequence: "DAILY", until: "06.11.2015"
    }
    event.save
    expect(event.max_date).to eq Date.new(2015, 11, 6)
  end

  it "set the max date according to the COUNT option" do
    event.recurrence_attributes = {
      frequence: "DAILY", count: "10"
    }
    event.save
    expect(event.max_date).to eq event.dtstart.to_date + 10.days
  end

  it "set the max date to ininity if no limit is provided" do
    event.recurrence_attributes = { frequence: "DAILY" }
    event.save
    expect(event.max_date).to eq DateTime::Infinity.new
  end

  it "set the max date to the end of the event if there is no recurrence rule" do
    expect(event.max_date).to eq event.dtend.to_date
  end

  describe "the getters" do

    it "returns the frequence" do
      event.recurrence_attributes = { frequence: "MONTHLY" }
      event.save
      expect(event.recurrence.frequence).to eq "MONTHLY"
    end

    it "returns the days in the month" do
      event.recurrence_attributes = { frequence: "MONTHLY", monthly: ["1", "2"] }
      event.save
      expect(event.recurrence.frequence).to eq "MONTHLY"
      expect(event.recurrence.monthly).to eq [1, 2]
    end

    it "returns the until date" do
      event.recurrence_attributes = { frequence: "MONTHLY", until: "06.11.2015" }
      event.save
      expect(event.recurrence.until).to eq Date.new(2015, 11, 6)
    end

    it "returns the count" do
      event.recurrence_attributes = { frequence: "MONTHLY", count: "10" }
      event.save
      expect(event.recurrence.count).to eq 10
    end
  end

end

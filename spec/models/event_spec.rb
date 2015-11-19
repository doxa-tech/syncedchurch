require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:event) { create(:event) }
  
  describe "recurrences" do

    it "saves an unique event" do
      event.recurrence_attributes = { frequence: "", monthly: "", count: "" }
      expect(event.rrule).to be_blank
    end

    it "saves an event with a frequency" do
      event.recurrence_attributes = { frequence: "WEEKLY" }
      expect(event.rrule).to eq "FREQ=WEEKLY"
    end

    it "saves an event with a monthly recurrence" do
      event.recurrence_attributes = { frequence: "MONTHLY", monthly: "2" }
      expect(event.rrule).to eq "FREQ=MONTHLY;BYDAY=2TH"
    end

    it "saves an event with a count" do
      event.recurrence_attributes = { frequence: "DAILY", count: "10" }
      expect(event.rrule).to eq "FREQ=DAILY;COUNT=10"
    end

    it "saves an event happening until a given date" do
      event.recurrence_attributes = { 
        frequence: "DAILY", until_1i: "2015", until_2i: "11", until_3i: "6", until_4i: "20", until_5i: "30" 
      }
      expect(event.rrule).to eq "FREQ=DAILY;UNTIL=20151106T203000Z"
    end

  end

  describe "recurrence validations" do

    it "doesn't allow to set BYDAY without a monthly frequence" do
      event.recurrence_attributes = { frequence: "DAILY", monthly: "2" }
      expect(event).not_to be_valid
    end

    it "doesn't allow to set count without a frequence" do
      event.recurrence_attributes = { count: "2" }
      expect(event).not_to be_valid
    end

    it "doesn't allow to set until without a frequence" do
      event.recurrence_attributes = { until_1i: "2015", until_2i: "11", until_3i: "6", until_4i: "20", until_5i: "30" }
      expect(event).not_to be_valid
    end

  end

end

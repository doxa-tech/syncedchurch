require 'rails_helper'

RSpec.describe RecurrenceValidator do
  let(:event) { create(:event) }

  it "doesn't allow to set BYDAY without a monthly frequence" do
    event.recurrence_attributes = { frequence: "DAILY", monthly: ["2"] }
    expect(event).not_to be_valid
  end

  it "doesn't allow to set count without a frequence" do
    event.recurrence_attributes = { count: "2" }
    expect(event).not_to be_valid
  end

  it "doesn't allow to set until without a frequence" do
    event.recurrence_attributes = { until: "06.11.2015" }
    expect(event).not_to be_valid
  end

end

require 'rails_helper'

RSpec.describe RecurrenceValidator do
  let(:event) { create(:event) }

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

require 'rails_helper'

RSpec.describe Group, type: :model do
  
  describe "validations" do

    it "should be invalid when the place option 'other' is selected without a specification" do
      member = build(:group, place: "other")
      expect(member).to be_invalid
    end

    it "should be valid when the place option 'other' is not selected and the specification is empty" do
      member = build(:group)
      expect(member).to be_valid
    end

  end

end

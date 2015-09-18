require 'rails_helper'

RSpec.describe FollowupsController, type: :controller do

  describe "POST #create" do

    it "creates a new follow up" do
      expect { post :create, followup: build(:followup).attributes }.to change { Followup.count }.by(1)
    end

  end

end
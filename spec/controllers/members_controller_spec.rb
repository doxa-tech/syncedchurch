require 'rails_helper'

RSpec.describe MembersController, type: :controller do

  describe "POST #create" do

    it "creates a new member" do
      expect { post :create, member: attributes_for(:member).merge(gender_id: 1) }.to change{ Member.count }.by(1)
    end

  end

end

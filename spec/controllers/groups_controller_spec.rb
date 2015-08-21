require 'rails_helper'

RSpec.describe GroupsController, type: :controller do

  describe "POST #create" do

    it "creates a new group" do
      expect { post :create, group: attributes_for(:group) }.to change { Group.count }.by(1)
    end

  end

end

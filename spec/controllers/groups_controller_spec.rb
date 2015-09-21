require 'rails_helper'

RSpec.describe GroupsController, type: :controller do

  describe "POST #create" do

    it "creates a new group" do
      expect { post :create, group: attributes_for(:group) }.to change { Group.count }.by(1)
    end

  end

  describe "DELETE #destroy" do

    it "deletes a record" do
      group = create(:group)
      expect { delete :destroy, id: group.id }.to change { Group.count }.by(-1)
    end

  end

end

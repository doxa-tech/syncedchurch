require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "POST #create" do

    it "creates an user" do
      expect { post :create, member_id: create(:member).id }.to change { User.count }.by(1)
    end

  end

  describe "DELETE #destroy" do

    it "destroys an user" do
      user = create(:user).user
      expect { delete :destroy, id: user.id }.to change { User.count }.by(-1)
    end

  end

end

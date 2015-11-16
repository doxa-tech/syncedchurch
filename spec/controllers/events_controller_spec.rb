require 'rails_helper'

RSpec.describe EventsController, type: :controller, permission: "events" do

  describe "POST #create" do

    it "creates a new event" do
      expect { post :create, event: attributes_for(:event) }.to change { Event.count }.by(1)
    end

    it "generates an uid" do
      post :create, event: attributes_for(:event)
      expect(assigns(:event).uid).not_to be_blank
    end

  end

  describe "DELETE #destroy" do

    it "deletes a record" do
      event = create(:event)
      expect { delete :destroy, id: event.id }.to change { Event.count }.by(-1)
    end

  end

end

require 'rails_helper'

RSpec.describe EventsController, type: :controller, permission: "events" do

  describe "POST #create" do
    before do
      @attributes = {
        title: "Nice event !",
        dstart: "01.01.2016",
        tstart: "20:00",
        dend: "01.01.2016",
        tend: "22:00",
        location: "EEBulle",
        visibility: "everyone",
        recurrence: {frequence: ""}
      }
    end

    it "creates a new event" do
      expect { post :create, params: { event: @attributes }}.to change { Event.count }.by(1)
    end

    it "generates an uid" do
      post :create, params: { event: @attributes }
      expect(assigns(:event).uid).not_to be_blank
    end

  end

  describe "DELETE #destroy" do

    it "deletes a record" do
      event = create(:event)
      expect { delete :destroy, params: { id: event.id }}.to change { Event.count }.by(-1)
    end

  end

end

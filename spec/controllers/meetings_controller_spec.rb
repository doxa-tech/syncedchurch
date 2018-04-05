require 'rails_helper'

RSpec.describe MeetingsController, type: :controller, permission: "meetings" do

  describe "DELETE #destroy" do

    it "deletes a record" do
      meeting = create(:meeting)
      expect { delete :destroy, params: { id: meeting.id }}.to change { Meeting.count }.by(-1)
    end

  end

end

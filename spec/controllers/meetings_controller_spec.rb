require 'rails_helper'

RSpec.describe MeetingsController, type: :controller do

  describe "DELETE #destroy" do

    it "deletes a record" do
      meeting = create(:meeting)
      expect { delete :destroy, id: meeting.id }.to change { Meeting.count }.by(-1)
    end

  end

end

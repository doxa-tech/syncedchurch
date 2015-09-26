require 'rails_helper'

RSpec.describe MeetingFile, type: :model do
  
  it "should store the size and the extension of the file" do
    file = create(:meeting_file)
    expect(file.size).not_to be_nil
    expect(file.extension).not_to be_nil
  end

end

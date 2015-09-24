class CreateAttendingMeetingMembers < ActiveRecord::Migration
  def change
    create_table :attending_meeting_members do |t|
      t.references :meeting, index: true, foreign_key: true
      t.references :member, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

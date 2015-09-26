class CreateMeetingFiles < ActiveRecord::Migration
  def change
    create_table :meeting_files do |t|
      t.string :name
      t.string :file
      t.string :extension
      t.integer :size
      t.references :meeting, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.date :date
      t.references :group, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

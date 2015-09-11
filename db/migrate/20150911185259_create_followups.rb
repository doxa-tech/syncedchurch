class CreateFollowups < ActiveRecord::Migration
  def change
    create_table :followups do |t|
      t.references :member, index: true, foreign_key: true

      t.integer :counselor_id
      t.index :counselor_id
      t.foreign_key :members, column_name: "counselor_id", name: "fk_counselors_followups"

      t.date :date
      t.integer :duration
      t.text :notes
      t.integer :place
      t.integer :reason

      t.timestamps null: false
    end
  end
end

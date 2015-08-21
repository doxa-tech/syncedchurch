class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :group_type
      t.integer :place
      t.string :place_other

      t.timestamps null: false
    end
  end
end

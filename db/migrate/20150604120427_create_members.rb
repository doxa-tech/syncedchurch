class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :firstname
      t.string :lastname
      t.date :birthday
      t.string :job
      t.string :adress
      t.integer :npa
      t.string :city
      t.string :email
      t.string :private, array: true, default: []
      t.text :extra

      t.timestamps null: false
    end
  end
end

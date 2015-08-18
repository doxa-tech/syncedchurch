class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :number
      t.references :member, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

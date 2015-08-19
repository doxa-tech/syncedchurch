class CreateFamilies < ActiveRecord::Migration
  def change
    create_table :families do |t|
      t.string :lastname

      t.timestamps null: false
    end
  end
end

class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :password_digest
      t.string :reset_token
      t.string :reset_send_at
      t.string :remember_token
      t.boolean :confirmed
      t.references :member, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

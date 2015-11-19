class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :dtstart
      t.datetime :dtend
      t.string :uid, index: true
      t.string :location
      t.string :url
      t.string :rrule
      t.string :image

      t.timestamps null: false
    end
  end
end

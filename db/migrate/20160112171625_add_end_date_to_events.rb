class AddEndDateToEvents < ActiveRecord::Migration
  def change
    add_column :events, :max_date, :date
  end
end

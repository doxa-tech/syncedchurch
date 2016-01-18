class AddCategoryToEvents < ActiveRecord::Migration
  def change
    add_column :events, :category, :integer, default: 0
  end
end

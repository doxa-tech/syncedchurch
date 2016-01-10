class AddVisibilityToEvents < ActiveRecord::Migration
  def change
    add_column :events, :visibility, :integer, default: 0
  end
end

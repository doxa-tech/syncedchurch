class AddPrivateToPhones < ActiveRecord::Migration
  def change
    add_column :phones, :private, :boolean
  end
end

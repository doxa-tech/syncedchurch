class AddGenderToMembers < ActiveRecord::Migration
  def change
    add_column :members, :gender, :integer
  end
end

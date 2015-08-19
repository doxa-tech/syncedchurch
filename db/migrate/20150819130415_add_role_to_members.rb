class AddRoleToMembers < ActiveRecord::Migration
  def change
    add_column :members, :role, :integer
  end
end

class AddFamilyIdToMembers < ActiveRecord::Migration
  def change
    add_reference :members, :family, index: true, foreign_key: true
  end
end

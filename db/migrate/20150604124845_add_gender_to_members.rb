class AddGenderToMembers < ActiveRecord::Migration
  def change
    add_reference :members, :gender, index: true, foreign_key: true
  end
end

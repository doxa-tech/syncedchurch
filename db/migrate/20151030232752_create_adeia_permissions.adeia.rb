# This migration comes from adeia (originally 20151003144208)
class CreateAdeiaPermissions < ActiveRecord::Migration
  def change
    create_table :adeia_permissions do |t|
      t.references :owner, polymorphic: true, index: true
      t.references :adeia_element, index: true, foreign_key: true
      t.integer :permission_type
      t.boolean :read_right
      t.boolean :create_right
      t.boolean :update_right
      t.boolean :destroy_right
      t.integer :resource_id

      t.timestamps null: false
    end
  end
end

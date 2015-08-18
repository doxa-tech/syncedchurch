class AddPhoneTypeToPhones < ActiveRecord::Migration
  def change
    add_reference :phones, :phone_type, index: true, foreign_key: true
  end
end

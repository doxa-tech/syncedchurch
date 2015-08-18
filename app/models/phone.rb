class Phone < ActiveRecord::Base
  belongs_to :member
  belongs_to :type, class_name: :PhoneType, foreign_key: :phone_type_id
end

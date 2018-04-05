class GroupMember < ApplicationRecord
  belongs_to :group
  belongs_to :member

  enum status: [:member, :responsable]
end

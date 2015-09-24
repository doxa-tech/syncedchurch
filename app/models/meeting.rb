class Meeting < ActiveRecord::Base

  validates :date, presence: true
  validates :group_id, presence: true
  validates :attending_members, presence: { message: :attending_member }

  belongs_to :group

  has_many :attending_meeting_members, dependent: :destroy
  has_many :attending_members, through: :attending_meeting_members, source: :member

  has_many :external_meeting_members, dependent: :destroy
  has_many :external_members, through: :external_meeting_members, source: :member
end

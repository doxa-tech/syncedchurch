class Meeting < ApplicationRecord

  validates :date, presence: true
  validates :group_id, presence: true
  validates :attending_members, presence: { message: :attending_member }

  belongs_to :group

  has_many :attending_meeting_members, dependent: :destroy
  has_many :attending_members, through: :attending_meeting_members, source: :member

  has_many :external_meeting_members, dependent: :destroy
  has_many :external_members, through: :external_meeting_members, source: :member

  has_many :files, class_name: :MeetingFile

  accepts_nested_attributes_for :files, allow_destroy: true, reject_if: proc { |a| a[:file].blank? && a[:name].blank? }
end

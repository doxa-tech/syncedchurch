class Member < ActiveRecord::Base
  enum gender: [:male, :female]
  enum role: [:father, :mother, :son, :daughter]

  attr_writer :status

  has_many :phones, dependent: :destroy
  belongs_to :family

  has_many :group_members, dependent: :destroy
  has_many :groups, through: :group_members

  has_many :followups, dependent: :destroy
  has_many :counselings, foreign_key: :counselor_id, class_name: :Followup, dependent: :destroy

  has_many :attending_meeting_members, dependent: :destroy
  has_many :attending_meetings, through: :attending_meeting_members, source: :meeting

  accepts_nested_attributes_for :phones, allow_destroy: true, reject_if: proc { |a| a[:number].blank? }

  validates :firstname, presence: true, length: { maximum: 100 }
  validates :lastname, presence: true, length: { maximum: 100 }
  validates :birthday, presence: true
  validates :gender, presence: true

  def family_attributes=(attributes)
    self.family_id = unless attributes[:lastname].blank?
      family = Family.find_or_create_by(lastname: attributes[:lastname])
      family.id
    end
  end

  def status
    GroupMember.statuses.key(self.status_id)
  end

  def full_name
    "#{firstname} #{lastname}"
  end

  def self.to_csv
    attributes = %w[id firstname lastname birthday job adress npa city email extra created_at updated_at gender] 

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << attributes.map{ |attr| user.send(attr) }
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      self.create row.to_hash
    end
  end
end

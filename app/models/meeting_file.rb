class MeetingFile < ApplicationRecord
  belongs_to :meeting

  mount_uploader :file, FileUploader

  validates :name, presence: true, length: { maximum: 100 }
  validates :file, presence: true

  after_save :set_file_attributes

  private

  def set_file_attributes
    if file.present? && file_changed?
      self.extension = file.file.extension.downcase
      self.size = file.size
    end
  end
end

class User < ActiveRecord::Base
  belongs_to :member

  has_secure_password

  before_save :create_remember_token

  def self.human_name
    model_name.i18n_key
  end

  def name
    member.full_name
  end

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end

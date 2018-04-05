class User < ApplicationRecord
  attr_accessor :current_password

  belongs_to :member

  has_secure_password

  before_save :create_remember_token

  def name
    member.full_name
  end

  def update_with_password(params)
    authenticated = authenticate(params[:current_password])
    assign_attributes(params)
    if valid? && authenticated
      save
      true
    else
      errors.add(:current_password, I18n.t("user.errors.messages.does_not_match")) unless authenticated
      false
    end
  end

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end

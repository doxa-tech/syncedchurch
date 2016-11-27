MailgunListManager.configure do |config|
  # Mailgun API key
  config.apikey = Rails.application.secrets.mailgun_api_key
  # Mailgun domain
  config.domain = Rails.application.secrets.mailgun_domain
end

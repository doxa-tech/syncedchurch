class UserTable < BaseTable

  def model
    User
  end

  def attributes
    [:id, { member: :full_name }, :confirmed, :created_at, :updated_at]
  end

end
class FollowupTable < BaseTable

  def model
    Followup
  end

  def attributes
    [:id, { member: :full_name }, { counselor: :full_name }, :date, :duration, :place, :reason, :created_at, :updated_at]
  end

end
class MeetingTable < BaseTable

  def model
    Meeting
  end

  def attributes
    [:id, :date, { group: :name } ,:created_at, :updated_at]
  end

end
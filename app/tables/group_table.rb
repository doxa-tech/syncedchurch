class GroupTable < BaseTable

  def model
    Group
  end

  def attributes
    [:id, { group_type: :name },  :created_at, :updated_at]
  end

  module Search

    def self.associations
      []
    end

    def self.fields
      { members: [:firstname, :lastname, :email, :job, :adress, :city] }
    end
  end

end
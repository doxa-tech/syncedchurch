class MemberTable < BaseTable

  def model
    Member
  end

  def attributes
    [:id, :firstname, :lastname, :email, :birthday, :job, :adress, :npa, :city, :created_at, :updated_at]
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
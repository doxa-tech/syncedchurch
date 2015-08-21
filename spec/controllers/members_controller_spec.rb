require 'rails_helper'

RSpec.describe MembersController, type: :controller do

  describe "POST #create" do

    it "creates a new member" do
      expect { post :create, member: attributes_for(:member) }.to change { Member.count }.by(1)
    end

    it "creates a new family" do
      expect { post :create, member: attributes_for(:member).merge(family_attributes: { lastname: "Johnson"} )}.to change { Family.count }.by(1)
    end

    it "finds an existing family" do
      Family.create(lastname: "Parkson")
      expect { post :create, member: attributes_for(:member).merge(family_attributes: { lastname: "Parkson"} )}.to change { Family.count }.by(0)
    end

  end

end
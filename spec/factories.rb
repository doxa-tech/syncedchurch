FactoryGirl.define do

  factory :member do
    firstname "John"
    lastname "Smith"
    birthday { 40.years.ago }
    gender "male"

    factory :group_member do
      firstname "Alfred"
      lastname "Dupont"
    end
  end

  factory :group do
    name "Conseil d'église"
    group_type "concil"
    place "church"

    members {[ Member.find_by_firstname("Alfred") || create(:group_member) ]}
  end

  factory :followup do
    member { Member.find_by_firstname("John") || create(:member) }
    counselor { Member.find_by_firstname("Alfred") || create(:group_member) }
    date { Date.today }
    place "home"
    reason "friendly"
    notes "Très bon partage"
    duration 20
  end
  
end
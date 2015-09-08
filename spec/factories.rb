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
  
end
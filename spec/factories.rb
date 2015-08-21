FactoryGirl.define do

  factory :member do
    firstname "John"
    lastname "Smith"
    birthday { 40.years.ago }
    gender "male"
  end

  factory :group do
    name "Conseil d'église"
    group_type "concil"
    place "church"
  end
  
end
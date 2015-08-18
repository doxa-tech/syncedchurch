FactoryGirl.define do

  factory :member do
    firstname "John"
    lastname "Smith"
    birthday { 40.years.ago }
    gender { Gender.find_or_create_by(name: "Homme") }
  end
  
end
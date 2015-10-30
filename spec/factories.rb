include ActionDispatch::TestProcess

FactoryGirl.define do

  factory :member do
    firstname "John"
    lastname "Smith"
    birthday { 40.years.ago }
    gender "male"
    email { "#{firstname.downcase}@#{lastname.downcase}.com" }

    factory :group_member do
      firstname "Alfred"
      lastname "Dupont"
    end

    factory :user do
      after(:create) do |member| 
        password = SecureRandom.hex(8)
        User.create!(member: member, password: password, password_confirmation: password)
      end
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

  factory :meeting do
    date { Date.today }
    group { Group.find_by_name("Conseil d'église") || create(:group) }
    attending_members {[ Member.find_by_firstname("Alfred") || create(:group_member) ]}
    external_members {[ Member.find_by_firstname("John") || create(:member) ]}
  end

  factory :meeting_file do
    name "PV"
    file { fixture_file_upload(File.join(Rails.root, '/spec/fixtures/files/projet.pdf'), 'text/pdf') }
  end

end
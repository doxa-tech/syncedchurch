namespace :seeds do

  desc "Setup the environment"
  task :all => [:genders, :phone_types]

  desc "Create the genders"
  task genders: :environment do
    %w(Homme Femme).each do |gender|
      Gender.find_or_create_by(name: gender)
    end
  end

  desc "Create the phone types"
  task phone_types: :environment do
    %w(Domicile Privé Travail).each do |type|
      PhoneType.find_or_create_by(name: type)
    end
  end

end
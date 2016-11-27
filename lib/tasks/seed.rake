namespace :seed do

  desc "Setup the environment"
  task :all => [:superuser]

  task superuser: :environment do
    puts "Firstname:"
    firsname = $stdin.gets.chomp
    puts "Lastname:"
    lastname = $stdin.gets.chomp
    puts "Email:"
    email = $stdin.gets.chomp
    puts "Gender (type 'male' or 'female'):"
    gender = $stdin.gets.chomp
    puts "Birthday (dd/mm/yyyy):"
    birthday = $stdin.gets.chomp
    puts "Password:"
    password = $stdin.gets.chomp
    begin
      member = Member.create!(firstname: firsname, lastname: lastname, gender: gender, birthday: Date.parse(birthday), email: email)
      User.create!(member: member, password: password, password_confirmation: password)
    rescue => error
      puts "Please fill in the questions correctly !"
      puts error.inspect
    end
  end

end

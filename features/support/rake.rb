module RakeTasks
  def execute_rake(file, task)
    require 'rake'
    rake = Rake::Application.new
    Rake.application = rake
    Rake::Task.define_task(:environment)
    load "#{Rails.root}/lib/tasks/#{file}"
    rake[task].invoke
  end
end

World(RakeTasks)

%w(genders phone_types).each do |task|

  Before("@#{task}") do
    execute_rake("seeds.rake", "seeds:#{task}")
  end

end
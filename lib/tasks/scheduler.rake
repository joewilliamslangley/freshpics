desc "This task is called by the Heroku scheduler add-on"
task :test_function => :environment do
  puts "Running a Test..."
end

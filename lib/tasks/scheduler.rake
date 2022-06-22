desc "This task is called by the Heroku scheduler add-on"
task :delete_bookmarks => :environment do
  puts "Running the Delete Bookmarks Job."
  RemovePlatformBookmarksJob.perform_now
end
# test
task :add_motn_data, [:min, :max] => :environment do
  puts "arg1 was: '#{args[:min]}' of class #{args[:min].class}"
  puts "arg2 was: '#{args[:max]}' of class #{args[:max].class}"
end

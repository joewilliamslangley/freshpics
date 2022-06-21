desc "This task is called by the Heroku scheduler add-on"
task :delete_bookmarks => :environment do
  puts "Running the Delete Bookmarks Job."
  RemovePlatformBookmarksJob.perform_now
end
# test

desc "This task is called by the Heroku scheduler add-on"
task :update_bookmarks => :environment do
  puts "Running Updating Bookmarks Job."
  RemovePlatformBookmarksJob.perform_now
end

desc "This task is called by the Heroku scheduler add-on"
task :delete_bookmarks => :environment do
  puts "Running the Delete Bookmarks Job."
  RemovePlatformBookmarksJob.perform_now
end
# test

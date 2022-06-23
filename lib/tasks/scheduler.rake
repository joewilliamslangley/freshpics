desc "This task deletes platform bookmarks once leave date has passed"
task :delete_bookmarks => :environment do
  puts "Running the Delete Bookmarks Job."
  RemovePlatformBookmarksJob.perform_now
end
# test

desc "This task adds new platform bookmarks and removes defunct ones"
task :update_bookmarks => :environment do
  puts "Running Updating Bookmarks Job."
  UpdatePlatformBookmarksJob.perform_now
end

desc "This task adds language info and updates the ratings of all movies"
task :update_bookmarks => :environment do
  puts "Running Updating Bookmarks Job."
  UpdateRatingsJob.perform_now
end

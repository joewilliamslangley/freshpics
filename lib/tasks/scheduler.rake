desc "This task is called by the Heroku scheduler add-on"
task :delete_bookmarks => :environment do
  puts "Running the Delete Bookmarks Job."
  RemovePlatformBookmarksJob.perform_now
end
# test
task :add_motn_data, [:min, :max] => :environment do |t, args|


end

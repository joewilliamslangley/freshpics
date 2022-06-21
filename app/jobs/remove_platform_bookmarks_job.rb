class RemovePlatformBookmarksJob < ApplicationJob
  queue_as :default

  def perform
    time = Time.now.to_i
    removed = PlatformBookmark.where('leaving < ?', time)
    puts removed.count
    removed.each do |bookmark|
      puts "#{bookmark.movie.title} on #{bookmark.platform.name} to be removed."
      bookmark.delete
    end
  end
end

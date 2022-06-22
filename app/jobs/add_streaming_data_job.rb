class AddStreamingDataJob < ApplicationJob
  queue_as :default

  def perform(min, max)
    add_streaming_data(min, max)
  end

  private

  def get_motn(movie_imdb_ref)
    url = URI("https://streaming-availability.p.rapidapi.com/get/basic?country=gb&imdb_id=#{movie_imdb_ref}&output_language=en")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["X-RapidAPI-Host"] = 'streaming-availability.p.rapidapi.com'
    request["X-RapidAPI-Key"] = ENV['MOTN_API']

    response = http.request(request)

    JSON.parse(response.read_body)
  rescue JSON::ParserError
    "Error"
  end

  def create_platform_bookmark(movie, platform, motn_data)
    platform_record = Platform.find_by(name: platform)
    bookmark = PlatformBookmark.new
    bookmark.movie = movie
    bookmark.platform = platform_record
    bookmark.added = motn_data["streamingInfo"][platform]["gb"]["added"]
    unless motn_data["streamingInfo"][platform]["gb"]["leaving"].zero?
      bookmark.leaving = motn_data["streamingInfo"][platform]["gb"]["leaving"]
    end
    bookmark.link = motn_data["streamingInfo"][platform]["gb"]["link"]
    bookmark.save!
    puts "Bookmark #{bookmark.id} - #{bookmark.movie.title} on #{bookmark.platform.name} "
  end

  def add_streaming_data(min, max)
    movies = Movie.where("id >= ?", min).where("id <= ?", max).order(:id)
    puts movies.count
    platforms = ["netflix", "prime", "all4", "disney", "mubi", "now", "iplayer", "britbox", "apple"]
    movies.each do |movie|
      motn_data = get_motn(movie.imdb_id)

      next if motn_data == "Error"

      movie.plot = motn_data["overview"]
      movie.director = motn_data["significants"]
      movie.stars = motn_data["cast"]
      movie.youtube_code = motn_data["video"]
      movie.background_image_url = motn_data["backdropURLs"]["original"]
      movie.save!
      platforms.each do |platform|
        create_platform_bookmark(movie, platform, motn_data) if motn_data["streamingInfo"][platform]
      end
      puts "#{movie.title} saved!"
      sleep 1
    end
  end
end

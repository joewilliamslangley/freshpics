require "json"
require "open-uri"
require "ostruct"
require 'uri'
require 'net/http'
require 'openssl'
require "nokogiri"

class UpdatePlatformBookmarksJob < ApplicationJob
  queue_as :default

  def perform
    platforms = Platform.all
    platforms.each do |platform|
      get_data("new", platform)
      get_data("removed", platform)
    end
  end

  private

  def get_data(new_removed, platform)
    url = URI("https://streaming-availability.p.rapidapi.com/changes?service=#{platform.name}&country=gb&change_type=#{new_removed}&type=movie&output_language=en")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["X-RapidAPI-Key"] = 'da14c8edd2msh6f445565845208ep1178f0jsnf3e97b0b51fe'
    request["X-RapidAPI-Host"] = 'streaming-availability.p.rapidapi.com'

    response = http.request(request)
    json = JSON.parse(response.read_body)["results"]

    json.each do |motn_data|
      next if (motn_data["originalTitle"] =~ /\w/).nil?

      next if motn_data["imdbVoteCount"] < 1000

      movie = Movie.find_by(imdb_id: motn_data["imdbID"])
      if new_removed == "new"
        create_platform_bookmark(movie, platform, motn_data)
      elsif movie
        bookmark = PlatformBookmark.find_by(movie_id: movie.id, platform_id: platform.id)
        bookmark&.delete
      end
    end
  end

  def create_platform_bookmark(movie, platform, motn_data)
    return_movie = add_movie_data(movie, motn_data)
    bookmark = PlatformBookmark.find_by(movie_id: return_movie.id, platform_id: platform.id)
    if bookmark.nil?
      bookmark = PlatformBookmark.new
      bookmark.movie = return_movie
      bookmark.platform = platform
    end
    bookmark.added = motn_data["streamingInfo"][platform.name]["gb"]["added"]
    unless motn_data["streamingInfo"][platform.name]["gb"]["leaving"].zero?
      bookmark.leaving = motn_data["streamingInfo"][platform.name]["gb"]["leaving"]
    end
    bookmark.link = motn_data["streamingInfo"][platform.name]["gb"]["link"]
    bookmark.save!
    puts "Bookmark #{bookmark.id} - #{bookmark.movie.title} on #{bookmark.platform.name}"
  rescue JSON::ParserError
    "Error"
  end

  def add_movie_data(movie, motn_data)
    if movie.nil?
      movie = Movie.new
      movie.imdb_id = motn_data["imdbID"]
      movie.title = motn_data["originalTitle"]
      movie.year = motn_data["year"]
      movie.poster_url = motn_data["posterURLs"]["780"]
      movie.runtime = motn_data["runtime"]
      movie.genres = get_genres(motn_data["genres"])
      movie.imdb_rating = motn_data["imdbRating"]
    end
    movie.plot = motn_data["overview"]
    movie.director = motn_data["significants"]
    movie.stars = motn_data["cast"]
    movie.youtube_code = motn_data["video"]
    movie.background_image_url = motn_data["backdropURLs"]["original"]
    movie.save!
    puts "#{movie.title} saved!"
    return movie
  end

  def get_genres(numbers)
    genres = { 1 => "Biography",
               2 => "Film Noir",
               3 => "Game Show",
               4 => "Musical",
               5 => "Sport",
               6 => "Short",
               7 => "Adult",
               12 => "Adventure",
               14 => "Fantasy",
               16 => "Animation",
               18 => "Drama",
               27 => "Horror",
               28 => "Action",
               35 => "Comedy",
               36 => "History",
               37 => "Western",
               53 => "Thriller",
               80 => "Crime",
               99 => "Documentary",
               878 => "Science Fiction",
               9648 => "Mystery",
               10402 => "Music",
               10749 => "Romance",
               10751 => "Family",
               10752 => "War",
               10763 => "News",
               10764 => "Reality",
               10767 => "Talk Show" }
    returned_genres = []
    numbers.each { |num| returned_genres.push(genres[num]) }
    returned_genres
  end
end

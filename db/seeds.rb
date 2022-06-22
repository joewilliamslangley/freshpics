require "json"
require "open-uri"
require "ostruct"
require 'uri'
require 'net/http'
require 'openssl'
require "nokogiri"

# Create 9 Platforms

def create_platforms(name, display_name)
  Platform.create!(name: name, logo_path: "#{name}.svg", display_name: display_name)
  puts "Created #{name}!"
end

def add_display_name_to(platform, display_name)
  platform.display_name = display_name
  platform.save!
end

# Platform.delete_all
# create_platforms('netflix', 'Netflix')
# create_platforms('all4', 'All4')
# create_platforms('apple', 'Apple TV+')
# create_platforms('britbox', 'BritBox')
# create_platforms('disney', 'Disney+')
# create_platforms('iplayer', 'iPlayer')
# create_platforms('mubi', 'Mubi')
# create_platforms('now', 'NowTV')
# create_platforms('prime', 'Prime Video')

# # Seedings From IMDb-API (https://imdb-api.com/api)

# Movie.delete_all
def create_movies(min, max)
  url = "https://imdb-api.com/API/AdvancedSearch/#{ENV['IMDB_API_KEY']}?title_type=feature&moviemeter=#{min},#{max}&count=250"

  serialized = URI.open(url).read

  movie_data = JSON.parse(serialized, object_class: OpenStruct).results

  movie_data.each do |result|
    star_list = []
    director = []

    unless result.stars.nil?
      star_list = result.stars.split(", ")
      director.push(star_list.shift)
    end
    next if Movie.find_by(imdb_id: result.id)

    movie = Movie.new
    movie.imdb_id = result.id
    movie.title = result.title
    movie.year = result.description.gsub(/[^0-9]/, '').to_i if result.description =~ /\d{4}/
    movie.poster_url = result.image
    movie.runtime = result.runtimeStr.gsub(/[^0-9]/, '').to_i if result.runtimeStr
    movie.genres = result.genres.split(", ") if result.genres
    movie.imdb_rating = (result.imDbRating.to_f * 10).to_i if result.imDbRating
    movie.metacritic_rating = result.metacriticRating
    movie.plot = result.plot
    movie.director = director
    movie.stars = star_list
    movie.save!
    puts "#{movie.title} saved"
  end
end

# Movie of the Night API Seed (https://rapidapi.com/movie-of-the-night-movie-of-the-night-default/api/streaming-availability/)

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
    sleep 2

  end
end


def add_imdb_data(min, max, last)
  while min < last
    create_movies(min, max)
    sleep 10
    min += 250
    max += 250
  end
end

# seed call to database

# create_movies(10250, 10500)

add_streaming_data(7501, 8000)

# add_imdb_data(10250, 10500, 32750)

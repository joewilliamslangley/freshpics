require "json"
require "open-uri"
require "ostruct"
require 'uri'
require 'net/http'
require 'openssl'

# Movie.delete_all

# # Seedings From IMDb-API (https://imdb-api.com/api)

# url = "https://imdb-api.com/API/AdvancedSearch/k_2ifnwqoj?title_type=feature&moviemeter=1,50"

# serialized = URI.open(url).read

# movie_data = JSON.parse(serialized, object_class: OpenStruct).results

# movie_data.each do |result|
#   star_list = []
#   director = []
#   unless result.stars.nil?
#     star_list = result.stars.split(", ")
#     director = director.push(star_list.shift)
#   end

#   movie = Movie.new
#   movie.imdb_id = result.id
#   movie.title = result.title
#   movie.year = result.description.gsub(/[^0-9]/, '').to_i if result.description =~ /\d{4}/
#   movie.poster_url = result.image
#   movie.runtime = result.runtimeStr.gsub(/[^0-9]/, '').to_i if result.runtimeStr
#   movie.genres = result.genres.split(" ,")
#   movie.imdb_rating = (result.imDbRating.to_f * 10).to_i if result.imDbRating
#   movie.metacritic_rating = result.metacriticRating
#   movie.plot = result.plot
#   movie.director = director
#   movie.stars = star_list
#   movie.save!
#   puts "#{movie.title} saved"
# end

# Movie of the Night API Seed (https://rapidapi.com/movie-of-the-night-movie-of-the-night-default/api/streaming-availability/)

def get_motn(movie_imdb_ref)
  url = URI("https://streaming-availability.p.rapidapi.com/get/basic?country=gb&imdb_id=#{movie_imdb_ref}&output_language=en")
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  request = Net::HTTP::Get.new(url)
  request["X-RapidAPI-Host"] = 'streaming-availability.p.rapidapi.com'
  request["X-RapidAPI-Key"] = 'da14c8edd2msh6f445565845208ep1178f0jsnf3e97b0b51fe'

  response = http.request(request)

  motn_data = JSON.parse(response.read_body, object_class: OpenStruct)
rescue JSON::ParserError
  "Error"
end

movies = Movie.all

movies.each do |movie|
  motn_data = get_motn(movie.imdb_id)

  unless motn_data == "Error"
    movie.plot = motn_data.overview
    movie.director = motn_data.significants
    movie.stars = motn_data.cast
    movie.trailer_url = "https://www.youtube.com/watch?v=#{motn_data.video}"
    movie.background_image_url = motn_data.backdropURLs.original
    movie.netflix = motn_data.streamingInfo.netflix.gb.link if motn_data.streamingInfo.netflix
    movie.prime = motn_data.streamingInfo.prime.gb.link if motn_data.streamingInfo.prime
    movie.disney = motn_data.streamingInfo.disney.gb.link if motn_data.streamingInfo.disney
    movie.mubi = motn_data.streamingInfo.mubi.gb.link if motn_data.streamingInfo.mubi
    movie.now = motn_data.streamingInfo.now.gb.link if motn_data.streamingInfo.now
    movie.all4 = motn_data.streamingInfo.all4.gb.link if motn_data.streamingInfo.all4
    movie.iplayer = motn_data.streamingInfo.iplayer.gb.link if motn_data.streamingInfo.iplayer
    movie.britbox = motn_data.streamingInfo.britbox.gb.link if motn_data.streamingInfo.britbox
    movie.apple = motn_data.streamingInfo.apple.gb.link if motn_data.streamingInfo.apple
    movie.save!
  end
  puts "#{movie.title} saved!"
end

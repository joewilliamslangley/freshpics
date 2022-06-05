require "json"
require "open-uri"
require "ostruct"
require 'uri'
require 'net/http'
require 'openssl'
require "nokogiri"

# Movie.delete_all

# # Seedings From IMDb-API (https://imdb-api.com/api)
# def imdb_api_secret_key
#   ENV["IMDB_API_KEY"]
# end

# api_data = { key: imdb_api_secret_key }

# # imdb_api_key = ENV['IMDB_API_KEY']

# url = "https://imdb-api.com/API/AdvancedSearch/#{api_data[:key]}?title_type=feature&moviemeter=451,600&count=250"

# serialized = URI.open(url).read

# movie_data = JSON.parse(serialized, object_class: OpenStruct).results

# movie_data.each do |result|
#   star_list = []
#   director = []
#   unless result.stars.nil?
#     star_list = result.stars.split(", ")
#     director.push(star_list.shift)
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

# def get_motn(movie_imdb_ref)
#   url = URI("https://streaming-availability.p.rapidapi.com/get/basic?country=gb&imdb_id=#{movie_imdb_ref}&output_language=en")
#   http = Net::HTTP.new(url.host, url.port)
#   http.use_ssl = true
#   http.verify_mode = OpenSSL::SSL::VERIFY_NONE

#   request = Net::HTTP::Get.new(url)
#   request["X-RapidAPI-Host"] = 'streaming-availability.p.rapidapi.com'
#   request["X-RapidAPI-Key"] = 'da14c8edd2msh6f445565845208ep1178f0jsnf3e97b0b51fe'

#   response = http.request(request)

#   motn_data = JSON.parse(response.read_body, object_class: OpenStruct)
# rescue JSON::ParserError
#   "Error"
# end

# movies = Movie.last(5)
# movies.each do |movie|
#   motn_data = get_motn(movie.imdb_id)

#   unless motn_data == "Error"
#     movie.plot = motn_data.overview
#     movie.director = motn_data.significants
#     movie.stars = motn_data.cast
#     movie.trailer_url = "https://www.youtube.com/watch?v=#{motn_data.video}"
#     movie.background_image_url = motn_data.backdropURLs.original
#     movie.netflix = motn_data.streamingInfo.netflix.gb.link if motn_data.streamingInfo.netflix
#     movie.prime = motn_data.streamingInfo.prime.gb.link if motn_data.streamingInfo.prime
#     movie.disney = motn_data.streamingInfo.disney.gb.link if motn_data.streamingInfo.disney
#     movie.mubi = motn_data.streamingInfo.mubi.gb.link if motn_data.streamingInfo.mubi
#     movie.now = motn_data.streamingInfo.now.gb.link if motn_data.streamingInfo.now
#     movie.all4 = motn_data.streamingInfo.all4.gb.link if motn_data.streamingInfo.all4
#     movie.iplayer = motn_data.streamingInfo.iplayer.gb.link if motn_data.streamingInfo.iplayer
#     movie.britbox = motn_data.streamingInfo.britbox.gb.link if motn_data.streamingInfo.britbox
#     movie.apple = motn_data.streamingInfo.apple.gb.link if motn_data.streamingInfo.apple
#     movie.save!
#   end
#   puts "#{movie.title} saved!"
# end

# Scrape from ReelGood

movie = Movie.find(257)

url = "https://reelgood.com/uk/movie/#{movie.title.downcase.gsub(" ", "-")}-#{movie.year}"

puts url

html = URI.open(url)
reelgood = Nokogiri::HTML(html)

reelgood.css(".css-r5iejs").each do |card|
  puts card.css('a').attribute("href")
  movie.prime = card.css('a').attribute("href").value if card.attribute("title").value == "Stream on Prime Video"
  # binding.pry
  movie.netflix = card.css('a').attribute("href").value if card.attribute("title").value == "Stream on Netflix"
  movie.disney = card.css('a').attribute("href").value if card.attribute("title").value == "Stream on Disney+"
  movie.mubi = card.css('a').attribute("href").value if card.attribute("title").value == "Stream on Mubi"
  movie.now = card.css('a').attribute("href").value if card.attribute("title").value == "Stream on NowTV"
  movie.all4 = card.css('a').attribute("href").value if card.attribute("title").value == "Stream on Channel 4"
  movie.iplayer = card.css('a').attribute("href").value if card.attribute("title").value == "Stream on BBC iPlayer"
  movie.britbox = card.css('a').attribute("href").value if card.attribute("title").value == "Stream on BritBox"
  movie.apple = card.css('a').attribute("href").value if card.attribute("title").value == "Stream on Apple TV+"
end

movie.save!

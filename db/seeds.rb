require "json"
require "open-uri"
require "ostruct"
require 'uri'
require 'net/http'
require 'openssl'

Movie.delete_all

# Seedings From IMDb-API (https://imdb-api.com/api)

url = "https://imdb-api.com/API/AdvancedSearch/k_2ifnwqoj?title_type=feature&moviemeter=1,50"

serialized = URI.open(url).read

movie_data = JSON.parse(serialized, object_class: OpenStruct).results

movie_data.each do |result|
  star_list = []
  director = []
  unless result.stars.nil?
    star_list = result.stars.split(", ")
    director = director.push(star_list.shift)
  end

  movie = Movie.new
  movie.imdb_id = result.id
  movie.title = result.title
  movie.year = result.description.gsub(/[^0-9]/, '').to_i if result.description =~ /\d{4}/
  movie.poster_url = result.image
  movie.runtime = result.runtimeStr.gsub(/[^0-9]/, '').to_i if result.runtimeStr
  movie.genres = result.genres.split(" ,")
  movie.imdb_rating = (result.imDbRating.to_f * 10).to_i if result.imDbRating
  movie.metacritic_rating = result.metacriticRating
  movie.plot = result.plot
  movie.director = director
  movie.stars = star_list
  movie.save!
  puts "#{movie.title} saved"
end

# Movie of the Night API Seed (https://rapidapi.com/movie-of-the-night-movie-of-the-night-default/api/streaming-availability/)

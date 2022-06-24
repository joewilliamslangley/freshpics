require 'uri'
require 'net/http'
require "json"
require 'openssl'
require "open-uri"

class UpdateRatingsJob < ApplicationJob
  queue_as :default

  def perform
    movies = Movie.all.order(:id)
    movies.each do |movie|
      movie_data = get_omdb_ratings(movie.imdb_id)
      next if movie_data == "Error"

      next if movie_data.Response == "False"

      movie.imdb_rating = (movie_data.imdbRating.to_f * 10).to_i if movie_data.imDbRating != "N/A"
      movie.metacritic_rating = movie_data.Metascore.to_i if movie_data.Metascore != "N/A"
      unless movie_data.Ratings.nil?
        movie_data.Ratings.each do |rating|
          movie.rotten_tomatoes_rating = rating.Value.gsub(/[^0-9]/, '').to_i if rating.Source == "Rotten Tomatoes"
        end
      end
      if movie_data.Language.split(", ")[0] == "English"
        movie.english = true
      else
        movie.english = false
      end
      movie.save!
      puts "#{movie.id}: #{movie.title} has been updated to English: #{movie.english}, IMDB: #{movie.imdb_rating}, Metacritic: #{movie.metacritic_rating}, Rotten Tomatoes: #{movie.rotten_tomatoes_rating}"
    end
  end

  private

  def get_omdb_ratings(movie_id)
    url = "https://www.omdbapi.com/?i=#{movie_id}&apikey=#{ENV['OMDB_KEY']}"
    serialized = URI.open(url).read
    JSON.parse(serialized, object_class: OpenStruct)
  rescue JSON::ParserError
    "Error"
  end
end

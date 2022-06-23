require 'uri'
require 'net/http'
require "json"
require 'openssl'
require "open-uri"

class UpdateRatingsJob < ApplicationJob
  queue_as :default

  def perform
    movies = Movie.first(20)
    movies.each do |movie|
      movie_data = get_omdb_ratings(movie.imdb_id)
      next if movie_data == "Error"

      movie.imdb_rating = (movie_data.imDbRating.to_f * 10).to_i if movie_data.imDbRating != "N/A"
      movie.metacritic_rating = movie_data.Metascore.to_i if movie_data.Metascore != "N/A"
      ratings.each do |rating|
        movie.rotten_tomatoes_rating = movie_data.Value.gsub(/[^0-9]/, '').to_i if movie_data.Source == "Rotten Tomatoes"
      end
      if movie_data.Language.split(", ")[0] == "English"
        movie.english = true
      else
        movie.english = false
      end
      movie.save!
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

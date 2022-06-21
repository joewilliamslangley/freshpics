require 'uri'
require 'net/http'
require "json"
require 'openssl'
require "open-uri"

class UpdateRatingsJob < ApplicationJob
  queue_as :default

  def perform(min, max)
    movies = Movie.where("id >= ?", min).where("id <= ?", max).order(:id)
    movies.each do |movie|
      movie_data = get_omdb_ratings
      movie.imdb_rating = (movie_data.imDbRating.to_f * 10).to_i if result.imDbRating != "N/A"
      movie.metacritic_rating = movie_data.Metascore.to_i
      ratings.each do |rating|
        movie.rotten_tomatoes_rating = rating.Value.gsub(/[^0-9]/, '').to_i if rating.Source == "Rotten Tomatoes"
      end
    end
  end

  private

  def get_omdb_ratings(movie_id)
    url = "https://www.omdbapi.com/?i=tt0110413&apikey=98973290"
    serialized = URI.open(url).read
    movie_data = JSON.parse(serialized, object_class: OpenStruct)
    movie_data
  end
end

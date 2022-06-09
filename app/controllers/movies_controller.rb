class MoviesController < ApplicationController
  def search

  end

  def search_results
    @movie = Movie.find(264)
  end
end

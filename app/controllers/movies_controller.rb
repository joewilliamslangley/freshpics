class MoviesController < ApplicationController
  def search
  end

  def search_results
    @movie = Movie.find(4)
  end

  def show
    @movie = Movie.find(params[:id])
    @movie_bookmark = MovieBookmark.new
  end

end

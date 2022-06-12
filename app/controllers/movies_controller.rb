class MoviesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:search, :search_results, :show]
  def search

  end

  def search_results
    @movie_bookmark = MovieBookmark.new
    @results = Movie.joins(:platform_bookmarks)
    @movies = @results[0..2]
    # Movie.where('genres && ?', "{Drama}")
    # Movie.where('runtime  < ?', "100").where('runtime  > ?', "90")
    # Movie.where('imdb_rating > ?', "70")
    # Movie.where('metacritic_rating > ?', '70')
  end

  def show
    @movie = Movie.find(params[:id])
    @movie_bookmark = MovieBookmark.new
  end

  private

  def movie_params
    params.require(:movie).permit(:term, :platforms, :imdb_rating, :metacritic_rating, :time)
  end
end

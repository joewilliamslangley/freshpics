class MoviesController < ApplicationController

  def search

  end

  def search_results
    results = Movie.joins(:platform_bookmarks)
    @movies = results.sample(3)
    # Movie.where('genres && ?', "{Drama}")
    # Movie.where('runtime  < ?', "100").where('runtime  > ?', "90")
    # Movie.where('imdb_rating > ?', "70")
    # Movie.where('metacritic_rating > ?', '70')

  end

  private

  def movie_params
    params.require(:movie).permit(:term, :platforms, :imdb_rating, :metacritic_rating, :time)
  end
end

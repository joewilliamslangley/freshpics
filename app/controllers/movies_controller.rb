class MoviesController < ApplicationController

  def search

  end

  def search_results
    @movies = Movie.all

    @movies = @movies.where('genres && ?', "{#{params[:keyword]}}") if params[:keyword] != ""

    @movies = @movies.where('metacritic_rating >= ?', params[:score]) if params[:review_site] == "metacritic" && params[:score]
    @movies = @movies.where('imdb_rating >= ?', params[:score]) if params[:review_site] == "imdb" && params[:score]
    @movies = @movies.where('runtime <= ?', params[:time]) unless params[:time] == "no_limit"

    # Movie.joins(platform_bookmarks: :platform).where(platform: {name: "netflix"})
    # Movie.joins(platform_bookmarks: :platform).where(platform: {id: user.platforms.ids})
  end

  private

  def user_platforms
    if current_user
      return current_user.platforms
    end
  end

  def movie_params
    params.require(:movie).permit(:term, :platforms, :imdb_rating, :metacritic_rating, :time)
  end
end

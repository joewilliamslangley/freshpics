class MoviesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:search, :search_results, :show]
  def search

    @genres = [["Don't Mind!", nil],
               ["Biography", "Biography"],
               ["Film Noir", "Film-Noir"],
               ["Musical", "Musical"],
               ["Sport", "Sport"],
               ["Short", "Short"],
               ["Adventure", "Adventure"],
               ["Fantasy", "Fantasy"],
               ["Animation", "Animation"],
               ["Drama", "Drama"],
               ["Horror", "Horror"],
               ["Action", "Action"],
               ["Comedy", "Comedy"],
               ["History", "History"],
               ["Western", "Western"],
               ["Thriller", "Thriller"],
               ["Crime", "Crime"],
               ["Documentary", "Documentary"],
               ["Science Fiction", "Sci-Fi"],
               ["Mystery", "Mystery"],
               ["Music", "Music"],
               ["Romance", "Romance"],
               ["Family", "Family"],
               ["War", "War"]]
  end

  def search_results
    # raise
    @movie_bookmark = MovieBookmark.new

    @movies = Movie.includes(:platform_bookmarks)
    @movies = @movies.where('genres && ?', "{#{params[:keyword]}}") if params[:keyword] != ""
    @movies = @movies.where('metacritic_rating >= ?', params[:score]) if params[:review_site] == "metacritic" && params[:score]
    @movies = @movies.where('imdb_rating >= ?', params[:score]) if params[:review_site] == "imdb" && params[:score]
    @movies = @movies.where('runtime <= ?', params[:time]) if params[:time] != "no_limit"
    if params[:platform_ids]
      @movies = @movies.joins(platform_bookmarks: :platform).where(platform: { id: params[:platform_ids] })
    else
      @movies = @movies.joins(platform_bookmarks: :platform).where(platform: { id: [1..9] })
    end
    if current_user
      user_watchlist = Movie.joins(movie_bookmarks: :user).where(user: { id: current_user.id })
      @movies = @movies.where.not(id: user_watchlist.ids)
    end


    # raise
    @movies = @movies.uniq.shuffle
    @movies = @movies[0..100]

  end

  def show
    @movie = Movie.find(params[:id])
    @movie_bookmark = MovieBookmark.new
  end

  # def result
  #   @movie = Movie.find(params)
  # end

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

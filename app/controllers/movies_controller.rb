class MoviesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:search, :search_results, :show]
  def search

    @genres =  [["Drama", "Drama"],
               ["Action", "Action"],
               ["Comedy", "Comedy"],
               ["Horror", "Horror"],
               ["Adventure", "Adventure"],
               ["Fantasy", "Fantasy"],
               ["Animation", "Animation"],
               ["Thriller", "Thriller"],
               ["Documentary", "Documentary"],
               ["Sci-Fi", "Sci-Fi"],
               ["History", "History"],
               ["Western", "Western"],
               ["Crime", "Crime"],
              #  ["Biography", "Biography"],
              #  ["Film Noir", "Film-Noir"],
               ["Musical", "Musical"],
              #  ["Sport", "Sport"],
              #  ["Short", "Short"],
              #  ["Mystery", "Mystery"],
              #  ["Music", "Music"],
                ["Romance", "Romance"],
               ["Family", "Family"],
              #  ["War", "War"],
               ]
    @skip = [["Don't Mind!", ""]]
  end

  def search_results
    # raise
    @movie_bookmark = MovieBookmark.new

    @movies = Movie.includes(:platform_bookmarks)
    @movies = @movies.where('genres && ?', "{#{params[:keyword]}}") if params[:keyword] != ""
    @movies = @movies.where('metacritic_rating >= ?', params[:score]) if params[:review_site] == "metacritic" && params[:score]
    @movies = @movies.where('imdb_rating >= ?', params[:score]) if params[:review_site] == "imdb" && params[:score]
    @movies = @movies.where('rotten_tomatoes_rating >= ?', params[:score]) if params[:review_site] == "rotten_tomatoes" && params[:score]
    @movies = @movies.where('runtime <= ?', params[:time]) if params[:time] != "180"
    @movies = @movies.where('year >= ?', params[:decade_from]) if params[:decade_from] && params[:decade_from] != "No Minimum"
    @movies = @movies.where('year <= ?', params[:decade_to]) if params[:decade_to] && params[:decade_to] != "No Maximum"
    # @movies = @movies.where(english: true) if params[:english] == 1
    if params[:platform_ids]
      params[:platform_ids] = params[:platform_ids].split if params[:platform_ids].kind_of?(String)
      # raise
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
    @user_bookmark = MovieBookmark.find_by(user_id: current_user.id, movie_id: @movie.id)
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

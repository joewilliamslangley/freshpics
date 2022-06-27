class MovieBookmarksController < ApplicationController
  def index
    @dislike_list = @user.movie_bookmarks.where(bookmark_type: "dislike")
  end

  def new
    @movie_bookmark = MovieBookmark.new
  end

  def create
    @movies = Movie.all
    @movie = Movie.find(params[:movie_bookmark][:movie])
    @movie_bookmark = MovieBookmark.new(movie_bookmark_params)
    @movie_bookmark.user = current_user
    @movie_bookmark.movie = @movie
    if @movie_bookmark.save
      # redirect_to user_path(current_user)
    else
      flash[:alert] = "Error"
    end
  end

  def destroy
    @movie_bookmark = MovieBookmark.find(params[:id])
    @movie = @movie_bookmark.movie
    @user = current_user
    @movie_bookmark.destroy
    redirect_to user_path(@user)
  end

  private

  def movie_bookmark_params
    params.require(:movie_bookmark).permit(:bookmark_type)
  end

end

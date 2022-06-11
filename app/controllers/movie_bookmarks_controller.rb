class MovieBookmarksController < ApplicationController
  def new
    @movie_bookmark = MovieBookmark.new
  end

  def create
    @movies = Movie.all
    @movie = Movie.find(params[:movie_bookmark][:movie])
    @movie_bookmark = MovieBookmark.new
    @movie_bookmark.user = current_user
    @movie_bookmark.movie = @movie
    @movie_bookmark.save!
    redirect_to user_path(current_user)
  end

  def destroy
    @movie_bookmark = MovieBookmark.find(params[:id])
    @user = current_user
    @movie_bookmark.destroy
    redirect_to user_path(@user)
  end
end

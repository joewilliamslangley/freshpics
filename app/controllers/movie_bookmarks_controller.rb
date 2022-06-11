class MovieBookmarksController < ApplicationController
  def create
    @movie = Movie.current_user.create!(movie_params)
  end

  def destroy
    @movie_bookmark = MovieBookmark.find(params[:id])
    @user = current_user
    @movie_bookmark.destroy
    redirect_to user_path(@user)
  end
end

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @movies = @user.movies
    @movie_bookmarks = @user.movie_bookmarks
  end
end

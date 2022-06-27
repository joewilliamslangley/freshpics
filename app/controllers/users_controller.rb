class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @watchlist = @user.movie_bookmarks.where(bookmark_type: "watchlist")
    @movie_bookmark = MovieBookmark.new
  end
end

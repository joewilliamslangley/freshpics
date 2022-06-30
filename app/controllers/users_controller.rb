class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @watchlist = @user.movie_bookmarks.where(bookmark_type: "watchlist").order(:created_at)
    @movie_bookmark = MovieBookmark.new
  end
end

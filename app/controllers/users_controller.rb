class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @movie_bookmarks = MovieBookmark.where(user: params[:id])
  end
end

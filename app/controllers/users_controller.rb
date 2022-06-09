class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @movies = @user.movies
  end
end

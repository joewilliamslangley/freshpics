class MovieBookmarksController < ApplicationController
  def create
    @movie = Movie.current_user.create!(movie_params)
  end
end

class MoviesController < ApplicationController
  def search
    if params[:query].present?
      @movies = Movie.where("title ILIKE ?", "%#{params[:query]}%")
    else
      @movies = Movie.all
    end
  end

  def search_results
    @movie = Movie.find(264)
  end
end

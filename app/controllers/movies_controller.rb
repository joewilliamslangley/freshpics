class MoviesController < ApplicationController
  def search

  end

  def search_results

  end

  private

  def movie_params
    params.require(:movie).permit(:term, )
  end

end

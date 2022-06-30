class MovieBookmarksController < ApplicationController
  def index
    dislikes = current_user.movie_bookmarks.where(bookmark_type: "dislike")
    @dislike_list = dislikes.includes(:movie).order('movies.title')
  end

  def new
    @movie_bookmark = MovieBookmark.new
  end

  def create
    @movies = Movie.all
    @movie = Movie.find(params[:movie_bookmark][:movie])
    @movie_bookmark = MovieBookmark.new(movie_bookmark_params)
    @movie_bookmark.user = current_user
    @movie_bookmark.movie = @movie
    if @movie_bookmark.save
      respond_to do |format|
        format.html { redirect_to movie_path(@movie, anchor: 'buttons-section') }
        format.js
      end
    else
      flash[:alert] = "Error"
    end
  end

  def destroy
    @movie_bookmark = MovieBookmark.find(params[:id])
    @movie = @movie_bookmark.movie
    @user = current_user
    @movie_bookmark.destroy
    respond_to do |format|
      format.html { redirect_to movie_path(@movie, anchor: 'buttons-section') }
      format.js
    end
  end

  private

  def movie_bookmark_params
    params.require(:movie_bookmark).permit(:bookmark_type)
  end

end

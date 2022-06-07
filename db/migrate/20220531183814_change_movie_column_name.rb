class ChangeMovieColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :movies, :imdb_ratings, :imdb_rating
  end
end

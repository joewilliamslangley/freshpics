class AddRottenTomatoesRatingToMovies < ActiveRecord::Migration[6.1]
  def change
    add_column :movies, :rotten_tomatoes_rating, :integer
  end
end

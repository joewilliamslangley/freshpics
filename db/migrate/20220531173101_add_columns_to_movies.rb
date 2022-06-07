class AddColumnsToMovies < ActiveRecord::Migration[6.1]
  def change
    add_column :movies, :title, :string
    add_column :movies, :year, :integer
    add_column :movies, :poster_url, :string
    add_column :movies, :runtime, :integer
    add_column :movies, :genres, :text, array: true, default: []
    add_column :movies, :imdb_ratings, :integer
    add_column :movies, :metacritic_rating, :integer
    add_column :movies, :plot, :text
    add_column :movies, :director, :text, array: true, default: []
    add_column :movies, :stars, :text, array: true, default: []
    add_column :movies, :trailer_url, :string
    add_column :movies, :english, :boolean
    add_column :movies, :background_image_url, :string
    add_column :movies, :netflix, :string, default: "Unavailable"
    add_column :movies, :prime, :string, default: "Unavailable"
    add_column :movies, :disney, :string, default: "Unavailable"
    add_column :movies, :mubi, :string, default: "Unavailable"
    add_column :movies, :now, :string, default: "Unavailable"
    add_column :movies, :all4, :string, default: "Unavailable"
    add_column :movies, :iplayer, :string, default: "Unavailable"
    add_column :movies, :britbox, :string, default: "Unavailable"
    add_column :movies, :apple, :string, default: "Unavailable"
  end
end

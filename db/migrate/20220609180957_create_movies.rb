class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :imdb_id
      t.string :title
      t.integer :year
      t.string :poster_url
      t.integer :runtime
      t.text :genres, array: true, default: []
      t.integer :imdb_rating
      t.integer :metacritic_rating
      t.text :plot
      t.text :director, array: true, default: []
      t.text :stars, array: true, default: []
      t.string :youtube_code
      t.boolean :english
      t.string :background_image_url

      t.timestamps
    end
  end
end

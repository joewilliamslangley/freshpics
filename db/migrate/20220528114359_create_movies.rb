class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :imdb_id

      t.timestamps
    end
  end
end

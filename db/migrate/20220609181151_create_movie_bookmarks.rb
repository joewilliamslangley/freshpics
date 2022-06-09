class CreateMovieBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :movie_bookmarks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true
      t.string :bookmark_type

      t.timestamps
    end
  end
end

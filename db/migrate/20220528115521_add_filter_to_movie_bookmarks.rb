class AddFilterToMovieBookmarks < ActiveRecord::Migration[6.1]
  def change
    add_column :movie_bookmarks, :type, :string
  end
end

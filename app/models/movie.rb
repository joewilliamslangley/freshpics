class Movie < ApplicationRecord
  has_many :movie_bookmarks
  has_many :platform_bookmarks
  has_many :platforms, through: :platform_bookmarks
  validates_presence_of :imdb_id, :title
end

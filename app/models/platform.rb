class Platform < ApplicationRecord
  has_many :platform_bookmarks
  has_many :movies, through: :movie_bookmarks
  validates_presence_of :name, :logo_path
end

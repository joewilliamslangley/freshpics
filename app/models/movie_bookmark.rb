class MovieBookmark < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  validates :user_id, uniqueness: { scope: :movie_id, message: "User has already bookmarked this movie" }
  # validates_presence_of :bookmark_type
end

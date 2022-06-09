class MovieBookmark < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  validates_presence_of :bookmark_type
end

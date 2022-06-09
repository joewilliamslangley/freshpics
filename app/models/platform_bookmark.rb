class PlatformBookmark < ApplicationRecord
  belongs_to :movie
  belongs_to :platform
  validates_presence_of :link
end

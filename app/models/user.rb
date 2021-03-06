class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :movie_bookmarks
  has_many :movies, through: :movie_bookmarks
  has_many :user_platforms
  has_many :platforms, through: :user_platforms
  validates_presence_of :freshpics_handle
end

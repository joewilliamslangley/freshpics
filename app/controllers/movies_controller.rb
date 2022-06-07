require 'uri'
require 'net/http'
require 'openssl'

class MoviesController < ApplicationController
  before_action :user_services
  before_action :genre_codes
  def search

  end

  def search_results
    page_number = 1
    # if not a user, then need to create an array of services, based on search request
    # need to then check each result to see if it is in the database.  If it is, then the id is saved to an array
  end

  private

  def movie_params
    params.require(:movie).permit(:term, :platforms, :imdb_rating, :metacritic_rating, :time)
  end

  def motn_search(page_number, services)
    url = URI("https://streaming-availability.p.rapidapi.com/search/ultra?country=gb&services=#{services.join("%2C")}&type=movie&order_by=imdb_vote_count&page=#{page}&genres=18%2C80&genres_relation=or&desc=true&language=en&min_imdb_rating=70&max_imdb_rating=90&min_imdb_vote_count=10000&max_imdb_vote_count=1000000&output_language=en")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["X-RapidAPI-Host"] = 'streaming-availability.p.rapidapi.com'
    request["X-RapidAPI-Key"] = ENV['MOTN_API']

    response = http.request(request)
    # need to return the response, which will include the number of pages, then repeat the search with a random page
  end

  def user_services
    user_services = ["all4", "iplayer"]
    if current_user
      user_services.push("netflix") if current_user.netflix == true
      user_services.push("prime") if current_user.prime == true
      user_services.push("mubi") if current_user.mubi == true
      user_services.push("now") if current_user.now == true
      user_services.push("britbox") if current_user.britbox == true
      user_services.push("apple") if current_user.apple == true
    end
    return user_services
  end

  def genre_codes
    {
      "1": "Biography",
      "2": "Film Noir",
      "3": "Game Show",
      "4": "Musical",
      "5": "Sport",
      "6": "Short",
      "7": "Adult",
      "12": "Adventure",
      "14": "Fantasy",
      "16": "Animation",
      "18": "Drama",
      "27": "Horror",
      "28": "Action",
      "35": "Comedy",
      "36": "History",
      "37": "Western",
      "53": "Thriller",
      "80": "Crime",
      "99": "Documentary",
      "878": "Science Fiction",
      "9648": "Mystery",
      "10402": "Music",
      "10749": "Romance",
      "10751": "Family",
      "10752": "War",
      "10763": "News",
      "10764": "Reality",
      "10767": "Talk Show"
    }
  end
end

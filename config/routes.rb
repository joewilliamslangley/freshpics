Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/search', to: 'movies#search'
  get 'movies', to: 'movies#searchresults'

  post '/movies', to: 'movies#create'
end

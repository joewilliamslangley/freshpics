Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/search', to: 'movies#search'
  get 'movies', to: 'movies#searchresults'

  resources :movie_bookmarks, only: [ :index, :show, :create, :destroy ]
end

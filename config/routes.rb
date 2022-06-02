Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  root to: 'pages#home'
  get '/search', to: 'movies#search'
  get 'movies', to: 'movies#search_results'

  resources :movie_bookmarks, only: [ :index, :show, :create, :destroy ]
  resources :users, only: [:show]
end

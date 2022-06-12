Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  root to: 'movies#search'
  get '/search', to: 'movies#search'
  get 'movies', to: 'movies#search_results'
  get 'movies/:id', to: 'movies#show', as: :movie

  resources :movie_bookmarks, only: [ :index, :show, :create, :destroy ]
  resources :users, only: [:show]
end

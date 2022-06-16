Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  root to: 'pages#home'
  get '/search', to: 'movies#search'
  get 'movies', to: 'movies#search_results'
  get 'movies/:id', to: 'movies#show', as: :movie
  get 'user_platforms/update_platforms', to: 'user_platforms#set_user_platforms'
  # get 'movies/:id/result', to: 'movies#result', as: :result

  resources :movie_bookmarks, only: [ :index, :show, :create, :destroy ]
  resources :users, only: [:show]
  resources :user_platforms, only: [:index]
end

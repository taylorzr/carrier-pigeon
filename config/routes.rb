Rails.application.routes.draw do

  root "welcome#index"

  resources :users
  # match '/signup' => 'users#new'

  resources :deliveries

  get '/login'  => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy', as: :logout


end

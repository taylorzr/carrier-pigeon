Rails.application.routes.draw do

  root "welcome#index"

  resources :users
  # match '/signup' => 'users#new'

  resources :deliveries

  get '/login'  => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'


end

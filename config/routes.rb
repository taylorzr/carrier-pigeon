Rails.application.routes.draw do

  root "welcome#index"

  resources :users do
    resources :recipients
  endgit

  resources :deliveries do
    resources :ratings
  end


  get '/login'  => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy', as: :logout


end

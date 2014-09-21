Rails.application.routes.draw do

  root "welcome#index"

  resources :users do
    resources :recipients
  end

  resources :deliveries do
    resources :ratings
  end

  resources :ratings

  get '/login'  => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy', as: :logout

end

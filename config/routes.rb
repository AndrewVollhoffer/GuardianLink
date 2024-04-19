Rails.application.routes.draw do
  resources :users

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get 'log-in', to: 'sessions#new'
  post 'log-in', to: 'sessions#create'
  delete 'log-out', to: 'sessions#destroy'

  get "users/home"

  # Defines the root path route ("/")
  root "users#home"
end
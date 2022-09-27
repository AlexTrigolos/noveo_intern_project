Rails.application.routes.draw do
  root 'pages#index'
  resources :bookings
  resources :reviews, only: [:index, :create]
  resources :rooms, only: [:index, :show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

Rails.application.routes.draw do
  root 'pages#index'
  resources :bookings
  resources :reviews, only: [:index, :create]
end

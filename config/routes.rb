Rails.application.routes.draw do
  namespace :admin do
    resources :bookings, only: [:index, :show, :update, :destroy]
    resources :reviews, only: [:index, :show, :update, :destroy]
    resources :rooms
  end
  root 'pages#index'
  resources :bookings
  resources :reviews, only: [:index, :create]
  resources :rooms, only: [:index, :show]
end

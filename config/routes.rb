Rails.application.routes.draw do
  devise_for :users
  namespace :admin do
    resources :bookings, only: [:index, :show, :update, :destroy]
    resources :reviews, only: [:index, :show, :update, :destroy]
    resources :rooms
    resources :room_photos, except: :new
  end
  root 'pages#index'
  resources :bookings
  resources :reviews, only: [:index, :create, :show]
  resources :rooms, only: [:index, :show]
end

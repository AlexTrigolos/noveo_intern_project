require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
  devise_for :users
  namespace :admin do
    resources :confirmed_bookings_files, only: :index do
      member do
        get :download
      end
    end
    resources :bookings, only: [:index, :show, :update, :destroy] do
      collection do
        get :confirmed_bookings
      end
    end
    resources :reviews, only: [:index, :show, :update, :destroy]
    resources :rooms
    resources :room_photos, except: :new
  end
  root 'pages#index'
  resources :bookings
  resources :reviews, only: [:index, :create, :show]
  resources :rooms, only: [:index, :show]
end

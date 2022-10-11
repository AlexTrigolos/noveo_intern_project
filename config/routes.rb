# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
  devise_for :users
  namespace :admin do
    resources :confirmed_bookings_files, only: :index do
      member do
        get :download
      end
    end
    resources :bookings, only: %i[index show update destroy] do
      collection do
        get :confirmed_bookings
      end
    end
    resources :reviews, only: %i[index show update destroy]
    resources :rooms
    resources :room_photos, except: :new
  end
  root 'pages#index'
  resources :bookings
  resources :reviews, only: %i[index create show]
  resources :rooms, only: %i[index show]
end

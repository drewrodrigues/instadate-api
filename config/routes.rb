# frozen_string_literal: true

Rails.application.routes.draw do
  resources :messages, only: :create
  resources :conversations, only: %i[index show create]
  patch '/instadates', to: 'instadates#update'
  put '/instadates', to: 'instadates#update'
  get 'search', to: 'search#index'
  resources :sparks, only: %i[index create destroy]
  resources :instadates, only: %i[create index destroy]
  resources :pictures, only: %i[create destroy]
  resources :users
  resources :sessions, only: :create
end

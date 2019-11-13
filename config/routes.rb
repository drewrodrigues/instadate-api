Rails.application.routes.draw do
  resources :locations, only: :index
  resources :pictures, only: %i[create destroy]
  resources :users
  resources :sessions, only: :create
end

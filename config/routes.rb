Rails.application.routes.draw do
  resources :pictures, only: %i[create destroy]
  resources :users
  resources :sessions, only: :create
end

Rails.application.routes.draw do
  get 'search', to: 'search#index'
  resources :instadates
  resources :locations, only: :index
  resources :pictures, only: %i[create destroy]
  resources :users
  resources :sessions, only: :create
end

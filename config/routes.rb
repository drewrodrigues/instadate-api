Rails.application.routes.draw do
  get 'search', to: 'search#index'
  patch '/instadates', to: 'instadates#update'
  put '/instadates', to: 'instadates#update'
  resources :instadates, only: %i[create index destroy]
  resources :locations, only: :index
  resources :pictures, only: %i[create destroy]
  resources :users
  resources :sessions, only: :create
end

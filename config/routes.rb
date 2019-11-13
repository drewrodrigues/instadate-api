Rails.application.routes.draw do
  resources :pictures, only: [:create, :destroy]
  resources :interested_ins
  resources :sexes
  resources :looking_fors
  resources :outcomes
  resources :users
  resources :sessions, only: :create
end

Rails.application.routes.draw do
  resources :interested_ins
  resources :sexes
  resources :looking_fors
  resources :outcomes
  resources :users
  resources :sessions, only: :create
end

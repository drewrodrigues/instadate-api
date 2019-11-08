Rails.application.routes.draw do
  resources :interested_ins
  resources :sexes
  resources :looking_fors
  resources :outcomes
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

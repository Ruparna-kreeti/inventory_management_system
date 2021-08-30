Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'application#index'
  resources :users
  resources :brands, only: [:index,:create,:edit,:update,:destroy]
  resources :categories, only: [:index,:create,:edit,:update,:destroy]
end

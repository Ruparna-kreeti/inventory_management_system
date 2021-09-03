Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'application#index'
  resources :users
  resources :brands, only: [:index,:create,:edit,:update,:destroy]
  resources :categories, only: [:index,:create,:edit,:update,:destroy]
  resources :employees do
    resources :issues, only: [:new,:create]
    get 'view_issues', to: 'employees#view_issues'
  end
  resources :issues, only: [:index,:edit,:update,:destroy]
  resources :items
  resources :storages
  resources :employees_items
end

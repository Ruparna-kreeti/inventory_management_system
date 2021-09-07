Rails.application.routes.draw do
  get 'employee_sessions/new'
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
  resources :admin_notifications do
    collection do
      post :mark_as_read
    end
  end
  resources :user_sessions, only: [:new, :create, :destroy]
  get '/login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  get 'logout', to: 'user_sessions#destroy'
  resources :employee_sessions, only: [:new, :create, :destroy]
  get '/employee_login', to: 'employee_sessions#new'
  post 'employee_login', to: 'employee_sessions#create'
  get 'employee_logout', to: 'employee_sessions#destroy'

end

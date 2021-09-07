Rails.application.routes.draw do
  get 'employee_sessions/new'
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
  resources :user_sessions, only: [:new, :create, :destroy]
  get '/login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  get 'logout', to: 'user_sessions#destroy'
  resources :employee_sessions, only: [:new, :create, :destroy]
  get '/employee_login', to: 'employee_sessions#new'
  post 'employee_login', to: 'employee_sessions#create'
  get 'employee_logout', to: 'employee_sessions#destroy'
  get 'auth/:provider/callback', to: 'user_sessions#googleAuth'
  get 'auth/failure', to: redirect('/')

end

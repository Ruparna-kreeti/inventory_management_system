# frozen_string_literal: true

Rails.application.routes.draw do
  root 'application#index'
  resources :users
  resources :brands
  resources :categories

  resources :employees do
    resources :issues, only: %i[new create]
    get 'view_issues', to: 'employees#view_issues'
  end

  resources :issues, only: %i[index edit update destroy]
  resources :items
  resources :storages
  resources :employees_items
  resources :user_sessions, only: %i[new destroy]
  get '/login', to: 'user_sessions#new'
  get 'logout', to: 'user_sessions#destroy'
  resources :employee_sessions, only: [:destroy]
  get 'employee_logout', to: 'employee_sessions#destroy'
  get 'auth/:provider/callback', to: 'user_sessions#google_auth'
  get 'auth/failure', to: redirect('/')
end

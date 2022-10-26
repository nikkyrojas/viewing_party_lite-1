# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'landing_page#index'

  get '/register', to: 'users#new'
  post '/register', to: 'users#create'
  delete '/logout', to: 'sessions#destroy'
  # resource :user, path: 'dashboard' #alternate way for line 11
  resource :dashboard, only: %i[show], controller: 'users'
  resources :login, only: %i[new create], controller: 'sessions'
  resources :users, only: %i[new create show] do
    resources :discover, only: [:index]
    resources :movies, only: %i[index show] do
      resources :viewing_party, only: %i[new create]
    end
  end
end


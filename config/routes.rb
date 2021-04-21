Rails.application.routes.draw do
  root to: 'articles#index'

  devise_for :users

  resources :articles
  
  resource :profile, only: [:show, :new, :create, :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

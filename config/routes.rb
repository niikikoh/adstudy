Rails.application.routes.draw do
  root to: 'timelines#show'

  devise_for :users

  resources :articles

  resources :accounts, only: [:show] do
    resources :relationships, only: [:create, :destroy]
  end
  
  resource :timeline, only: [:show]
  resource :profile,  only: [:show, :new, :create, :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

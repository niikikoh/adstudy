Rails.application.routes.draw do
  root to: 'articles#index'

  devise_for :users

  devise_scope :user do
    post 'user/guest_sign_in', to: 'user/sessions#guest_sign_in'
  end

  resources :articles do
    resource :like,      only: [:show, :create, :destroy]
    resources :comments, only: [:create]
  end

  resources :accounts, only: [:show] do
    resources :relationships, only: [:create, :destroy]
  end
  
  resource :timeline, only: [:show]
  resource :profile,  only: [:show, :new, :create, :edit, :update]

  # Stripeのルーティング
  resources :payments
end

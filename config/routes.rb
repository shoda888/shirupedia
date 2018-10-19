Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'
  resources :likes, only: [:create, :destroy]
  resources :nices, only: [:create, :destroy]
  resource :sessions
  resources :users
  resources :profiles
  resources :covers do
    resources :comments, only: [:create, :destroy, :update]
  end
  resources :questions do
    resources :answers
    member do
      put :fire
    end
  end
  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :users
    end
  end
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'
  get 'matelpage/index' => 'matelpage#index'
  resource :sessions
  resources :users
  resources :profiles
  resources :communities
  resources :questions do
    resources :answers
    member do
      put :fire
    end
  end
  namespace :api, {format: 'json'} do
    namespace :v1 do
      resources :users
    end
  end
end

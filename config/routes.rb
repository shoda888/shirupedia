Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'
  resource :sessions
  resources :users
  resources :profiles
  resources :communities
  resources :answers
  resources :questions
end

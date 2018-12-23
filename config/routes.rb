Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'
  resources :likes, only: [:create, :destroy]
  resources :nices, only: [:create, :destroy]
  resource :sessions
  resources :users
  resources :profiles, param: :token do
    member do
      get 'answered', to: 'profiles#answered'
      get 'questioned', to: 'profiles#questioned'
      get 'recommended', to: 'profiles#recommended'
    end
  end
  resources :covers do
    collection do
      post 'post', to: 'covers#post'
    end
    member do
      delete 'remove', to: 'covers#remove'
    end
    resources :comments, only: [:create, :destroy, :update]
  end
  resources :questions do
    collection do
      get 'newpost', to: 'questions#newpost'
      # get 'post/:id', to: 'questions#detail'
      post 'post', to: 'questions#post'
      post 'content_post', to: 'questions#content_post'
    end
    resources :answers
    member do
      put :fire
    end
  end
  namespace :api, { format: 'json' } do
    post '/users/signup', to: 'users#signup'
    post '/users/signin', to: 'users#signin'
    resources :users
    resources :questions do
      resources :answers
    end
    resources :profiles
    resources :covers
  end
end

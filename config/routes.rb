Rails.application.routes.draw do
  devise_for :users
  
  resources :users, only: [:show,:index,:edit,:update] do
    member do
      get 'followers'
      get 'followings'
    end
    resource :relationships, only: [:create, :destroy]
  end
  
  resources :books, only: [:index,:show,:edit,:create,:update,:destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create,:destroy]
  end
  
  root to: 'homes#top'
  get 'homes/about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

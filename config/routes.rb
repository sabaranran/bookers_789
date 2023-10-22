Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users
  
  root to: 'homes#top'
  get 'homes/about'
  
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
  
  resources :messages, only: [:create]
  resources :rooms, only: [:create,:show]
  
  
  
end

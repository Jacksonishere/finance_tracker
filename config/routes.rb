Rails.application.routes.draw do
  #home page
  root 'pages#index'

  #devise routes for user auth
  devise_for :users
  #show user profile page
  resources :users, only: [:show]

  #for handling ajax request
  get 'search_stock', to: 'searches#stock'
  get 'search_person', to: 'searches#person'

  #handling user_stock
  resources :user_stocks, only: [:create, :destroy]

  #user portfolio
  get 'portfolio', to: 'users#portfolio'
  #user friends
  get 'friends', to: 'users#friends'
   
  #handling friendships
  resources :friendships, only: [:create, :destroy]
end

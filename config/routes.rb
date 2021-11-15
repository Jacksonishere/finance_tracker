Rails.application.routes.draw do
  #home page
  root 'pages#index'

  #devise routes for user auth
  devise_for :users

  #user portfolio
  get 'portfolio', to: 'users#portfolio'
  #for handling ajax request
  get 'search_stock', to: 'stocks#search'
  
  #for handling tracking the stock for user.
  resources :user_stocks, only: [:create, :destroy]

  #for friends
  get 'friends', to: 'users#friends'
end

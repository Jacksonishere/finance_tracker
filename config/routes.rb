Rails.application.routes.draw do
  root 'pages#index'
  devise_for :users
  #user portfolio
  get 'portfolio', to: 'users#portfolio'
  get 'search_stock', to: 'stocks#search'
  
  resources :user_stocks, only: [:create]
end

Rails.application.routes.draw do
  
  root 'users#new'
  
  resources :users
  resources :sessions, only:[:new, :create, :destroy]
  resources :password_changes, only:[:edit, :update], as: 'password'
  resources :pictures, only:[:new, :create, :show, :destroy]


end

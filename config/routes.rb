Rails.application.routes.draw do
  
  root 'users#new'
  
  resources :users
  resources :sessions, only:[:new, :create, :destroy]
  resources :password_changes, only:[:edit, :update], as: 'password'
  # get '/password_change/edit', to: 'password_changes/edit', as: 'password'


end

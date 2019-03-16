Rails.application.routes.draw do
  
  root 'users#new'
  get 'pages/home', to: 'pages#home'
  get 'users/term', to: 'users#term'
  
  resources :users
  resources :sessions, only:[:new, :create, :destroy]
  resources :password_changes, only:[:edit, :update], as: 'password'
  resources :pictures, only:[:new, :create, :show, :destroy]
  resources :comments, only:[:new, :create, :index, :destroy]
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships,       only: [:create, :destroy]

end

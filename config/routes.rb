Rails.application.routes.draw do
  resources :friends
  post 'friends', to: 'friends#create', as: 'add_friend'
  resources :posts do
    resources :comments
  end
  get 'users/show'
  resources :rooms do
    resources :messages
  end
  devise_for :users, controllers:{
    registrations: "auth/registrations",
    sessions: "auth/sessions", to:"auth/sessions#new"
  }
  devise_scope :user do
    post "logout", to: "auth/sessions#logout"
  end
  root 'pages#index', as: 'home'
  get 'u/:id', to: 'users#profile', as: 'user_profile'
  get 'user/:id', to: 'users#show', as: 'user'
end

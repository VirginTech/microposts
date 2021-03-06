Rails.application.routes.draw do
  root to: 'static_pages#home'
  get 'signup',  to: 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  
  #get 'followings' => 'users#followings'
  #get 'followers' => 'users#followers'
  
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts
  resources :relationships, only: [:create, :destroy]
  resources :bookmarks, only: [:create, :destroy]
  resources :retweets, only: [:create, :destroy]
  
  #メンバールーティング
  resources :users do
    member do
      get 'following'
      get 'follower'
      get 'bookmarking'
      #get 'bookmarker'
    end
  end

end
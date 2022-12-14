Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'top#main'
  get '/auth/spotify/callback', to: 'users#spotify'
  get 'top/recommendations'
  get '/top/top_tracks'
  get '/top/login'
  get '/top/user_update'
  get '/top/form_test'
  resources :users
  resources :friends
  resources :notifications
  resources :music_requests
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'top#main'
  get '/auth/spotify/callback', to: 'users#spotify'
  get 'top/recommendations', to: 'top#recommendations'
  get '/top/top_tracks', to: 'top#top_tracks'
  get '/top/login', to: 'top#login'
  get '/top/user_update'
  resources :users
  resources :friends
end

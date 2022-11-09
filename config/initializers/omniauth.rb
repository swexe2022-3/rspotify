# config/initializers/omniauth.rb

require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_SECRET_ID'], scope: 'user-read-email playlist-modify-public user-library-read user-library-modify user-top-read user-follow-read'
end

OmniAuth.config.allowed_request_methods = [:post, :get]
class UsersController < ApplicationController
    def spotify
        spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
        hash = spotify_user.to_hash
        spotify_user = RSpotify::User.new(hash)
        session[:spotify_uid] = spotify_user.id
        redirect_to root_path
    end
    def create
        user = User.create(spotify_uid: session[:spotify_uid])
        user.save
        redirect_to root_path
    end
end
class UsersController < ApplicationController
    def spotify
        spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
        hash = spotify_user.to_hash
        spotify_user = RSpotify::User.new(hash)
        session[:spotify_uid] = spotify_user.id
        redirect_to '/top/top_tracks'
    end
end
class UsersController < ApplicationController
    def spotify
        spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
        hash = spotify_user.to_hash
        spotify_user = RSpotify::User.new(hash)
        session[:spotify_uid] = spotify_user.id
        @user = User.find_or_create_by!(spotify_uid: session[:spotify_uid])
        redirect_to top_user_update_path
    end
    def show
        @user = User.find(params[:id])
    end
end
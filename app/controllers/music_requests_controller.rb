class MusicRequestsController < ApplicationController
    def create
        MusicRequest.create!(user_spotify_id: params[:user_spotify_id], friend_spotify_id: params[:friend_spotify_id], music_title: params[:music_title])
        redirect_to "/top_tracks"
    end
    def destroy 
        MusicRequest.find(params[:id]).destroy
        redirect_to "/notifications/#{current_user.id}"
    end
end

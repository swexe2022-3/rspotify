class MusicRequestsController < ApplicationController
    def create
        #リクエストを受けるユーザー
        user = User.find_by(spotify_uid: params[:user_spotify_uid])
        mr = MusicRequest.new(f_user_id: current_user.id, music_title: params[:music_title] )
        user.music_requests << mr
        redirect_to "/top/top_tracks"
    end
    def destroy 
        MusicRequest.find(params[:id]).destroy
        redirect_to "/notifications/#{current_user.id}"
    end
end

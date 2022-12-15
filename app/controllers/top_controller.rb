require 'rspotify'
class TopController < ApplicationController

    RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_SECRET_ID'])
    #ログインsessionの判定、ユーザーモデルに登録されていればインスタンスを返して、なければ生成する。
    def main
        if session[:spotify_uid]
            @user = User.find_or_create_by!(spotify_uid: session[:spotify_uid])
        else
            render 'login'
        end
    end
    
    #spotifyのoauthでログインした後、ユーザーのステータスを返信したいから,ここにredirectさせる
    def user_update
        current_user.update_status_from_spotify
        redirect_to root_path
    end
    
    def top_tracks
        #アクセストークンの有効時間が切れたらNameErrorがでるのでrescue
        begin
            @spotify_user = RSpotify::User.find(session[:spotify_uid])
            @my_top_tracks = @spotify_user.top_tracks(limit: 50, time_range: 'short_term')
            @group_tracks = User.get_groups_top_tracks(current_user)
            #form用のfriends配列　[友達のspotify_uid...]
            @request = MusicRequest.new
            #@friends = current_user.friends.to_uid_array
            @friends = Friend.all
            @group_tracks = User.get_groups_top_tracks(current_user)
        rescue NameError
            redirect_to '/auth/spotify'
        rescue NoMethodError
            
        end
    end

    def create_mytop_playlist
        spotify_user = RSpotify::User.find(session[:spotify_uid])
        playlist = spotify_user.create_playlist!('Ranking')
        playlist.add_tracks!(RSpotify::User.find(session[:spotify_uid]).top_tracks(limit: 50, time_range: 'short_term'))
        puts "OK"
    end
    
    def create_grouptop_playlist
        spotify_user = RSpotify::User.find(session[:spotify_uid])
        playlist = spotify_user.create_playlist!('Group Ranking')
        User.get_groups_top_tracks(current_user, 1).each do |track_uri|
            playlist.add_tracks!([track_uri.first.to_s])
        end
        
        puts "OK"
    end
        
end

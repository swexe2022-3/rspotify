class TopController < ApplicationController
    require 'rspotify'
    RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_SECRET_ID'])
    #ログインsessionの判定、ユーザーモデルに登録されていればインスタンスを返して、なければcする。
    def main
        if session[:spotify_uid]
            @user = User.find_or_create_by!(spotify_uid: session[:spotify_uid])
        else
            render 'login'
        end
    end
    
    #spotifyのoauthでログインした後、ユーザーのステータスを返信したいから,ここにredirectさせる
    def user_update
        ary = []
        sum_energy = 0
        sum_positive = 0
        spotify_user = RSpotify::User.find(session[:spotify_uid])
        
        spotify_user.top_tracks(limit: 50, time_range: 'short_term').each_with_index do |track, rank|
            
            audio_feature_data_json = RSpotify.get("https://api.spotify.com/v1/audio-features/#{track.id}")
            sum_energy += audio_feature_data_json["energy"].to_f
            sum_positive += audio_feature_data_json["valence"].to_f
            ary += track.artists.first.genres
            
        end
        
        tracksize = spotify_user.top_tracks.size()
        average_energy = (sum_energy / tracksize * 100).round(0)
        average_positive = (sum_positive / tracksize * 100).round(0)
        favority_genre = ary.group_by(&:itself).max_by{|_, v| v.size}[0]
        
        User.find_by(spotify_uid: session[:spotify_uid]).update(energy: average_energy, positive: average_positive, genre: favority_genre)
        
        redirect_to root_path
    end
    
    def top_tracks
        #アクセストークンの有効時間が切れたらNameErrorがでるのでrescue
        begin
            @spotify_user = RSpotify::User.find(session[:spotify_uid])
            @group_tracks = get_groups_top_tracks(User.find_by(spotify_uid: session[:spotify_uid]))
            @request = MusicRequest.new
            #form用のfriends配列　[友達のspotify_uid...]
            @friends = []
            friends = Friend.where(uid: current_user.spotify_uid)
            friends.each do |f|
                @friends.push f.friend_uid
            end
        rescue NameError
            render 'login'
        end
    end
    
    def recommendations
        @recommendations = RSpotify::Recommendations.generate(limit: 20, seed_genres: ['alt_rock'], seed_artists: ['4NHQUGzhtTLFvgF5SZesLK'], target_energy: 1.0)
    end
    
    def login
        
    end
    
    def get_groups_top_tracks(user)
        result = {}
        RSpotify::User.find(session[:spotify_uid]).top_tracks(limit: 50, time_range: 'short_term').each_with_index do |track, rank|
            result.store(track.id, 50-rank)
        end
        puts result
        Friend.where(uid: session[:spotify_uid]).each do |f|
            begin
                r = {}
                if friend = RSpotify::User.find(f.friend_uid)
                    friend.top_tracks(limit: 50, time_range: 'short_term').each_with_index do |track, rank|
                        r.store(track.id, 50-rank)
                    end
                end
                result.merge!(r) {|key, v0, v1| v0 + v1}
            rescue NameError
            end
        end
        result = result.sort_by { |_, v| v }
        return result.reverse.slice(0..50)
    end
        
end

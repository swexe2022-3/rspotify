class TopController < ApplicationController
    require 'rspotify'
    RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_SECRET_ID'])
    def main
        if session[:spotify_uid]
            @user = User.find_or_create_by!(spotify_uid: session[:spotify_uid])
        else
            render 'login'
        end
    end
    def user_update
        ary = []
        sum_energy = 0
        sum_positive = 0
        spotify_user = RSpotify::User.find(session[:spotify_uid])
        
        spotify_user.top_tracks(limit: 50, time_range: 'short_term').each_with_index do |track, rank|
            
            audio_feature_data_json = RSpotify.get("https://api.spotify.com/v1/audio-features/#{track.id}")
            sum_energy += audio_feature_data_json["energy"].to_f
            sum_positive += audio_feature_data_json["positive"].to_f
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
        begin
            @spotify_user = RSpotify::User.find(session[:spotify_uid])
            puts "----"
            puts get_groups_top_tracks(User.find_by(spotify_uid: session[:spotify_uid]))
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
        user.friends.each do |f|
            r = {}
            if friend = RSpotify::User.find(f.friend_uid)
                friend.top_tracks(limit: 50, time_range: 'short_term').each_with_index do |track, rank|
                    r.store(track, 50-rank)
                end
            end
            result.merge(r) {|key, v0, v1| v0 + v1}
        end
        result.sort_by { |_, v| v }
        return result.to_a.slice(0..50)
    end
        
end

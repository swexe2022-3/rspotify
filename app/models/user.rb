class User < ApplicationRecord
    has_many :friends, dependent: :destroy
    has_many :music_requests, dependent: :destroy
    
    
    def update_status_from_spotify
        ary = []
        sum_energy = 0
        sum_positive = 0
        spotify_user = RSpotify::User.find(self.spotify_uid)
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
        self.update(energy: average_energy, positive: average_positive, genre: favority_genre)
    end
    
    
    
    #現在のユーザー以外のユーザー表示
    def self.to_uid_array(current_user)
        users = User.all
        users_array = []
        users.each do |f|
            next if f.id == current_user.id
            users_array.push f.spotify_uid
        end
        return users_array
    end
    
    
    def self.find_user_id_session
        User.find_by(spotify_uid: session[:spotify_uid]).id
    end
    
    
    def self.id_to_spotify_name(id)
        user = User.find(id)
        RSpotify::User.find(user.spotify_uid).display_name
    end
    
    
    def self.get_groups_top_tracks(current_user, get_uri = 0)
        result = {}
        music_limit = 10
        RSpotify::User.find(current_user.spotify_uid).top_tracks(limit: music_limit, time_range: 'short_term').each_with_index do |track, rank|
            
            if get_uri == 0
                result.store(track.id, music_limit-rank)
            elsif get_uri == 1
                result.store(track.uri, music_limit-rank)
            end
        end
        puts result
        current_user.friends.each do |f|
            
            begin
                r = {}
                if friend = RSpotify::User.find(f.f_spotify_uid)
                    friend.top_tracks(limit: music_limit, time_range: 'short_term').each_with_index do |track, rank|
                        
                        if get_uri == 0
                            r.store(track.id, music_limit-rank)
                        elsif get_uri == 1
                            r.store(track.uri, music_limit-rank)
                        end
                        
                    end
                end
                result.merge!(r) {|key, v0, v1| v0 + v1}
                
            rescue NameError
            end
            
        end
        result = result.sort_by { |_, v| v }
        return result.reverse.slice(0..music_limit-1)
    end
    
end

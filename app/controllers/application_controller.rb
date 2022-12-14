class ApplicationController < ActionController::Base
    helper_method :spotify_user_name, :current_user
    #display_nameでspotifyのnicknameを収得
    def spotify_user_name
        if session[:spotify_uid]
            RSpotify::User.find(session[:spotify_uid]).display_name
        end
    end
    def current_user
        User.find_by(spotify_uid: session[:spotify_uid])
    end
end

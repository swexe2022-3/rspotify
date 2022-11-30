class ApplicationController < ActionController::Base
    helper_method :spotify_user_name
    #display_nameでspotifyのnicknameを収得
    def spotify_user_name
        if session[:spotify_uid]
            RSpotify::User.find(session[:spotify_uid]).display_name
        end
    end
end

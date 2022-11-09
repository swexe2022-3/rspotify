class TopController < ApplicationController
    require 'rspotify'
    RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_SECRET_ID'])
    def main
        
    end
    
    def top_tracks
        @spotify_user = RSpotify::User.find(session[:spotify_uid])
    end
end

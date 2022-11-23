class TopController < ApplicationController
    require 'rspotify'
    RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_SECRET_ID'])
    def main
        if session[:spotify_uid]
            if User.find_by(spotify_uid: session[:spotify_uid])
            else
                render 'signup'
            end
        else
            render 'login'
        end
    end

    def top_tracks
        @spotify_user = RSpotify::User.find(session[:spotify_uid])
    end
    
    def recommendations
        @recommendations = RSpotify::Recommendations.generate(limit: 20, seed_genres: ['alt_rock'], seed_artists: ['4NHQUGzhtTLFvgF5SZesLK'], target_energy: 1.0)
    end
    
    def login
        
    end
end

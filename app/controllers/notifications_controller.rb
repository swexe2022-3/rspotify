class NotificationsController < ApplicationController
    def show
        @requests = MusicRequest.where(spotify_uid: session[:spotify_uid])
    end
end

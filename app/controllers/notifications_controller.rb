class NotificationsController < ApplicationController
    def show
        @requests = MusicRequest.where(spotify_uid: current_user.spotify_uid)
    end
end

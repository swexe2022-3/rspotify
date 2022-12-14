class NotificationsController < ApplicationController
    #種々のリクエストを表示
    def show
        @requests = MusicRequest.where(user_spotify_id: current_user.spotify_uid)
    end
end

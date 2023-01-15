class NotificationsController < ApplicationController
    #種々のリクエストを表示
    def show
        @requests = current_user.music_requests
    end
end

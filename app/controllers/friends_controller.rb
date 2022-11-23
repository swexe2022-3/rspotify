class FriendsController < ApplicationController
    def index
        @friends = Friend.where(uid: session[:spotify_uid])
        @friend = Friend.new
    end
    def create
        friend = Friend.create(uid: session[:spotify_uid], friend_uid: params[:friend][:friend_uid], user_id: User.find_by(spotify_uid: session[:spotify_uid]))
        friend.save
        redirect_to '/friends'
    end
    def destroy
    end
    def show
    end
end

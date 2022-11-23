class FriendsController < ApplicationController
    def index
        @friends = Friend.where(uid: session[:spotify_uid])
        @friend = Friend.new
    end
    def create
        Friend.create(uid: session[:spotify_uid], friend_uid: params[:friend][:friend_uid])
    end
    def destroy
    end
    def show
    end
end

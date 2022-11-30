class FriendsController < ApplicationController
    def index
        @friends = Friend.where(uid: session[:spotify_uid])
        @friend = Friend.new
    end
    def create
        if User.find_by(spotify_uid: params[:friend][:friend_uid])
            friend = Friend.create(uid: session[:spotify_uid], friend_uid: params[:friend][:friend_uid], user_id: User.find_by(spotify_uid: session[:spotify_uid]))
            friend.save
            redirect_to '/friends'
        else 
            redirect_to '/friends',:notice => 'not found'
        end
    end
    def destroy
    end
    def show
    end
end

class FriendsController < ApplicationController
    def index
        @friends = Friend.where(uid: session[:spotify_uid])
        @friend = Friend.new
    end
    def create
        #入力したuidのユーザーと友達なのか確認
        if Friend.find_by(uid: session[:spotify_uid], friend_uid: params[:friend][:friend_uid])
            redirect_to '/friends',flash: {fail: 'already friend'}
        else
            #入力したuidのユーザーがいるか確認
            if User.find_by(spotify_uid: params[:friend][:friend_uid])
                Friend.create!(uid: session[:spotify_uid], friend_uid: params[:friend][:friend_uid], user_id: User.find_by(spotify_uid: session[:spotify_uid]).id.to_i)
                redirect_to '/friends',flash: {success: 'Success to add'}
            else 
                redirect_to '/friends',flash: {fail: 'id not found'}
            end
        end
    end
    def destroy
        friend = Friend.find(params[:id])
        friend.destroy
        redirect_to '/friends'
    end
    def show
    end
end

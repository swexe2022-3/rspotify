class FriendsController < ApplicationController
    def index
        @friends = Friend.where(user_id: current_user.id)
        @friend = Friend.new
        @users = User.to_uid_array(current_user)
    end
    def create
        f_spotify_uid = params[:friend][:f_spotify_uid]
        #入力したuidのユーザーがいるか確認 
        if  User.find_by!(spotify_uid: f_spotify_uid).nil?
            redirect_to '/friends',flash: {fail: 'user not found'}
        #入力したuidのユーザーと友達なのか確認    
        elsif Friend.find_by(user_id: current_user.id, f_spotify_uid: f_spotify_uid)
            redirect_to '/friends',flash: {fail: 'already friend'}
        #追加
        else
            Friend.follow(f_spotify_uid.to_s, current_user)
            redirect_to '/friends',flash: {success: 'Success to add'}
        end
    end

    def destroy
        friend = Friend.find(params[:id])
        friend.destroy
        redirect_to '/friends'
    end
    def show
    end
    private
        def post_params
            p arams.require(:post).permit(:title, :summary, :description, :url)
        end
end

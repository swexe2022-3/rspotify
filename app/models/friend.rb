class Friend < ApplicationRecord
    belongs_to :user
    
    def self.follow(f_spotify_uid, current_user)
        p f_spotify_uid + "f_spotify_uid"
        Friend.create(f_spotify_uid: f_spotify_uid, user_id: current_user.id.to_i)
    end
    def to_uid_array
        friends_array = []
        self.each do  |f|
            friends_array.push f.f_spotify_uid
        end
        friends_array
    end
    def self.to_uid_array(current_user)
        friends = Friend.where(user_id: current_user.id)
        friends_array = []
        friends.each do  |f|
            friends_array.push f.f_spotify_uid
        end
        friends_array
    end
end



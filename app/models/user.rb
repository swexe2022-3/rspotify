class User < ApplicationRecord
    has_many :friends, dependent: :destroy
    def self.find_user_id_session
        find_by(spotify_uid: session[:spotify_uid]).id
    end
end

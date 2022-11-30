class Friend < ApplicationRecord
    belongs_to :user, optional: true
    validates :friend_uid, presence: true
end

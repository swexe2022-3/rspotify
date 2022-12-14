class MusicRequest < ApplicationRecord
    belongs_to :user
    validates :music_title, uniqueness: { case_sensitive: false }
end

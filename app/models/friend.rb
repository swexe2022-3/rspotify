class Friend < ApplicationRecord
    belongs_to :user, optional: true
end

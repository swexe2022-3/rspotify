class User < ApplicationRecord
    has_many :friends, dependent: :destroy
    
end

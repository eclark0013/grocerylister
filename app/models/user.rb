class User < ApplicationRecord
    has_secure_password
    validates :name, presence: true

    has_many :lists
    
    has_many :recipes
end

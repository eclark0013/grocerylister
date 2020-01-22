class User < ApplicationRecord
    has_secure_password
    validates :name, presence: true
    has_many :lists
    has_many :recipes
    has_many :user_stores
    has_many :stores, through: :user_stores
end

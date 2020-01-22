class Store < ApplicationRecord
    validates :name, presence: true # (possibly should add validation for address)
    has_many :areas
    has_many :store_items
    has_many :items, through: :store_items
    has_many :users, through: :user_stores
end

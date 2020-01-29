class Item < ApplicationRecord
    validates :name, presence: true

    has_many :store_items
    has_many :stores, through: :store_items

    has_many :additional_items
    has_many :lists, through: :additional_items

    has_many :recipe_items
    has_many :recipes, through: :recipe_items

    has_many :list_items

    attr_accessor :quantity

end

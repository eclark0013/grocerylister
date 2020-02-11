class Item < ApplicationRecord
    validates :name, presence: true

    has_many :additional_items
    has_many :lists, through: :additional_items

    has_many :recipe_items
    has_many :recipes, through: :recipe_items

    has_many :purchase_items

    belongs_to :grocery_category

    attr_accessor :quantity

end

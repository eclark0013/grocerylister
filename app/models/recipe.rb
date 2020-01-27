class Recipe < ApplicationRecord
    validates :name, presence: true
    
    has_many :recipe_items 
    has_many :items, through: :recipe_items
    
    has_many :list_recipes
    has_many :lists, through: :list_recipes
    belongs_to :user

    accepts_nested_attributes_for :items
    accepts_nested_attributes_for :recipe_items
end

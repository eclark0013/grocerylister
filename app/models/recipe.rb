class Recipe < ApplicationRecord
    validates :name, presence: true
    has_many :recipe_items #view should allow for input to be auto-filled
end

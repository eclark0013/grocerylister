class List < ApplicationRecord #(nested under users?)
    validates :name, presence: true
    has_many :list_items
    has_many :items, through :list_items
    has many :recipes
    has_many :recipe_items, through: :recipes
    has_many :items, through: :recipe_items
    belongs_to :user

    # def set_name (method that changes the name to the time it was updated in a readable format if it is left empty)
    # the view page should contain a note about how this is what it will do if it is left blank
end

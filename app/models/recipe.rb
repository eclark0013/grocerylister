class Recipe < ApplicationRecord
    validates :name, presence: true
    has_many :recipe_items #view should allow for input to be auto-filled
    has_many :items, through: :recipe_items
    belongs_to :user

    accepts_nested_attributes_for :items
    accepts_nested_attributes_for :recipe_items
end

# <%= items_fields.label :quantity %>
# <%= items_fields.text_field :quantity %>

# <%= f.fields_for :recipe_items, RecipeItem.create do |recipe_items_fields| %>
#     <%= recipe_items_fields.label :quantity %>
#     <%= recipe_items_fields.text_field :quantity %>
# <% end %>
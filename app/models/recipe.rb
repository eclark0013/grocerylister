class Recipe < ApplicationRecord
    validates :name, presence: true
    
    has_many :recipe_items 
    has_many :items, through: :recipe_items
    
    has_many :list_recipes
    has_many :lists, through: :list_recipes
    belongs_to :user

    # accepts_nested_attributes_for :items
    accepts_nested_attributes_for :recipe_items

    def included
    end

    def add_items(recipe_params)
        (0..recipe_params[:recipe_items_attributes].length-1).each do |num|
            num = num.to_s
            recipe_items_attributes = recipe_params[:recipe_items_attributes]
            unless recipe_items_attributes[num][:name].strip.empty?
                item = Item.find_or_create_by(name: recipe_items_attributes[num][:name])
                @recipe_item = self.recipe_items.build(
                    item_id: item.id, 
                    quantity: recipe_params[:recipe_items_attributes][num][:quantity]
                    )
                @recipe_item.save
            end
        end
    end

    def update_recipe(recipe_params)
        self.name = recipe_params[:name]
        self.directions = recipe_params[:directions]
        self.recipe_items.destroy_all # because otherwise removed ingredients will still be part of the recipe
        (0..(recipe_params[:recipe_items_attributes].length - 1)).each do |num|
            num = num.to_s
            recipe_items_attributes = recipe_params[:recipe_items_attributes]
            unless recipe_items_attributes[num][:name].strip.empty?
                item = Item.find_or_create_by(name: recipe_items_attributes[num][:name])
                @recipe_item = RecipeItem.find_or_create_by(item_id: item.id)
                @recipe_item.recipe = self
                @recipe_item.quantity = recipe_params[:recipe_items_attributes][num][:quantity]
                @recipe_item.save
            end
        end
        self.save
    end

end

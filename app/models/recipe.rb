class Recipe < ApplicationRecord
    validates :name, presence: true
    # validates :items, :length => {:minimum => 1, :message => "must be present in recipe."}
    # won't work because recipe_items cannot be created without a recipe and vice versa
    
    has_many :recipe_items 
    has_many :items, through: :recipe_items
    
    has_many :list_recipes
    has_many :lists, through: :list_recipes
    
    belongs_to :user

    accepts_nested_attributes_for :recipe_items

    attr_reader :included

    def self.most_ingredients
        self.order(recipe_items_count: :desc).limit(1).first
    end

    def self.most_popular
        self.order(popularity: :desc).limit(1).first
    end

    def update_popularity
        self.popularity = self.list_recipes.length
        self.save
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

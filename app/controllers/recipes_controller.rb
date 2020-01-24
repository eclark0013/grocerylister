class RecipesController < ApplicationController
    def index
        if current_user
            @your_recipes = Recipe.where(user_id: current_user.id)
            @public_recipes = Recipe.where.not(user_id: current_user.id)
        else
            redirect_to "/login"
        end
    end

    def show
        @recipe = Recipe.find(params[:id])
    end

    def new
        @recipe = Recipe.new
    end

    def create
        @recipe = Recipe.create(
            user: current_user, 
            name: recipe_params[:name], 
            directions: recipe_params[:directions]
            )
        (0..19).each do |num|
            item_attributes = recipe_params[:items_attributes][num.to_s]
            unless item_attributes[:name].strip.empty?
                item = Item.find_or_create_by(name: item_attributes[:name])
                @recipe.recipe_items.build(item_id: item.id, quantity: item_attributes[:quantity]).save
            end
        end
        redirect_to recipe_path(@recipe)
    end

    private
    def recipe_params
        params.require(:recipe).permit(:name, :directions, item_ids:[], items_attributes: [:name, :quantity])
    end 
end

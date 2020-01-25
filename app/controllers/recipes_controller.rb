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
        (0..recipe_params[:recipe_items_attributes].length-1).each do |num|
            num = num.to_s
            recipe_items_attributes = recipe_params[:recipe_items_attributes]
            unless recipe_items_attributes[num][:item_name].strip.empty?
                item = Item.find_or_create_by(name: recipe_items_attributes[num][:item_name])
                @recipe_item = @recipe.recipe_items.build(
                    item_id: item.id, 
                    quantity: recipe_params[:recipe_items_attributes][num][:quantity]
                    )
                @recipe_item.save
            end
        end
        redirect_to recipe_path(@recipe)
    end

    def edit
        @recipe = Recipe.find(params[:id])
    end

    def update
        @recipe = Recipe.find(params[:id])
        @recipe.name = recipe_params[:name]
        @recipe.directions = recipe_params[:directions]
        @recipe.recipe_items.destroy_all # because otherwise removed ingredients will still be part of the recipe
        (0..(recipe_params[:recipe_items_attributes].length - 1)).each do |num|
            num = num.to_s
            recipe_items_attributes = recipe_params[:recipe_items_attributes]
            unless recipe_items_attributes[num][:item_name].strip.empty?
                item = Item.find_or_create_by(name: recipe_items_attributes[num][:item_name])
                @recipe_item = RecipeItem.find_or_create_by(item_id: item.id)
                @recipe_item.recipe = @recipe
                @recipe_item.quantity = recipe_params[:recipe_items_attributes][num][:quantity]
                @recipe_item.save
            end
        end
        @recipe.save
        redirect_to recipe_path(@recipe)
    end

    def destroy 
        Recipe.find(params[:id]).destroy
        redirect_to recipes_path
    end

    private
    def recipe_params
        params.require(:recipe).permit(:name, :directions, recipe_item_ids:[], recipe_items_attributes: [:quantity, :item_name]).to_h
    end 
end

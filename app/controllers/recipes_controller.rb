class RecipesController < ApplicationController
    before_action :require_login
    
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
        @recipe.add_items(recipe_params)
        redirect_to recipe_path(@recipe)
    end

    def edit
        @recipe = Recipe.find(params[:id])
    end

    def update
        @recipe = Recipe.find(params[:id])
        @recipe.update_recipe(recipe_params)
        redirect_to recipe_path(@recipe)
    end

    def destroy 
        Recipe.find(params[:id]).destroy
        redirect_to recipes_path
    end

    private
    def recipe_params
        params.require(:recipe).permit(:name, :directions, recipe_item_ids:[], recipe_items_attributes: [:quantity, :name]).to_h
    end 
end

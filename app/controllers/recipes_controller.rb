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
        if @recipe.errors.any?
            if @recipe.errors[:name].any?
                flash[:error_messages] = @recipe.errors.full_messages_for(:name)
            else
                flash[:error_messages] = @recipe.errors.full_messages
            end
            render "recipes/new"
        else
            redirect_to recipe_path(@recipe)
        end
    end

    def edit
        @recipe = Recipe.find(params[:id])
    end

    def update
        @recipe = Recipe.find(params[:id])
        @recipe.update_recipe(recipe_params)
        if @recipe.errors.any?
            if @recipe.errors[:name].any?
                flash[:error_messages] = @recipe.errors.full_messages_for(:name)
            else
                flash[:error_messages] = @recipe.errors.full_messages
            end
            redirect_to edit_recipe_path(@recipe)
        else
            redirect_to recipe_path(@recipe)
        end
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

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
        raise recipe_params.inspect
        @recipe = Recipe.create(name)
    end

    private
    def recipe_params
        params.require(:recipe).permit(:name, :directions, item_ids:[], items_attributes: [:name, :quantity])
    end 
end

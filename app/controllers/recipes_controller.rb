class RecipesController < ApplicationController
    def index
        @your_recipes = Recipe.where(user_id: current_user.id)
        @public_recipes = Recipe.where.not(user_id: current_user.id)
    end
end

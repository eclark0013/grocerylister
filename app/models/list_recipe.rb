class ListRecipe < ApplicationRecord
    after_save :update_recipe_popularity
    after_update :update_recipe_popularity
    after_destroy :update_recipe_popularity
    
    belongs_to :list
    belongs_to :recipe 

    def update_recipe_popularity
        self.recipe.update_popularity
    end
end

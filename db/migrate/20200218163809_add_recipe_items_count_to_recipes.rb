class AddRecipeItemsCountToRecipes < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :recipe_items_count, :integer
  end
end

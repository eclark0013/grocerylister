class AddPopularityToRecipe < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :popularity, :integer, default: 0
  end
end

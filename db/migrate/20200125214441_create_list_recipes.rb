class CreateListRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :list_recipes do |t|
      t.integer :list_id
      t.integer :recipe_id

      t.timestamps
    end
  end
end

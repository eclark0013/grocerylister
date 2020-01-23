class CreateGroceryCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :grocery_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end

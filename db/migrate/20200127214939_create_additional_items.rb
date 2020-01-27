class CreateAdditionalItems < ActiveRecord::Migration[5.2]
  def change
    create_table :additional_items do |t|
      t.integer :list_id
      t.integer :item_id
      t.string :quantity

      t.timestamps
    end
  end
end

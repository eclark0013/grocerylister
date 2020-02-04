class CreatePurchaseItems < ActiveRecord::Migration[5.2]
  def change
    create_table :purchase_items do |t|
      t.string :name
      t.string :quantity, default: ""
      t.integer :item_id

      t.timestamps
    end
  end
end

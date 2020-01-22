class AddAvailabilityToStoreItems < ActiveRecord::Migration[5.2]
  def change
    add_column :store_items, :availability, :boolean, :default => true
  end
end

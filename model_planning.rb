Area
    Migration
        t.string :name
        t.integer :store_id
    Model
        validates :name, presence: true
        belongs_to :store
Store
    Migration  
        t.string :name
        t.string :address
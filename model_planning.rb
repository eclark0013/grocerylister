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
    Model
        validates :name, presence: true (possibly should add validation for address)
        has_many :areas
        has_many :store_items
        has_many :items, through: :store_items
        has_many :users, through: :user_stores
Store_item
    Migration
        t.integer :store_id
        t.integer :item_id
    Model
        belongs_to :store
        belongs_to :item
        #available? (defaults to true, open for extension)
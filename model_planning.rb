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
Item
    Migration
        t.string :name (view should allow for input to be auto-filled)
    Model
        validates :name, presence: true
        has_many :store_items
        has_many :stores, through: :store_items
        has_many :list_items
        has_many :lists, through: :list_items
        has_many :recipe_items
        has_many :recipes, through: :recipe_items
List_item
    Migration
        t.integer :list_id
        t.integer :item_id
        t.string :quantity
    Model
        belongs_to :list
        belongs_to :item
Recipe
    Migration
        t.string :name
        t.string :directions
    Model
        validates :name, presence: true
        has_many :recipe_items (view should allow for input to be auto-filled)
Recipe_item
    Migration
        t.integer :recipe_id
        t.integer :item_id
        t.string :quantity
    Model
        belongs_to :recipe
        belongs_to :item
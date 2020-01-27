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
        has_many :individual_items
        has_many :lists, through: :individual_items
        has_many :recipe_items
        has_many :recipes, through: :recipe_items
Individual_item
    Migration
        t.integer :list_id
        t.integer :item_id
        t.string :quantity
    Model
        belongs_to :list
        belongs_to :item
Recipe (nested under users?)
    Migration
        t.string :name
        t.text :directions
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
List (nested under users?)
    Migration
        t.string :name
        t.integer :user_id
    Model   
        validates :name, presence: true
        #set_name (method that changes the name to the time it was updated in a readable format if it is left empty)
        # the view page should contain a note about how this is what it will do if it is left blank
        has_many :individual_items
        has_many :items, through :individual_items
        has many :recipes
        has_many :recipe_items, through: :recipes
        has_many :items, through: :recipe_items
        belongs_to :user
User
    Migration
        t.string :name
        t.string :password_digest
    Model
        has_secure_password
        has_many :lists
        has_many :recipes
        has_many :user_stores
        has_many :stores, through: :user_stores
User_stores
    Migration
        :user_id
        :store_id
    Model
        belongs_to :user 
        belongs_to :store
        
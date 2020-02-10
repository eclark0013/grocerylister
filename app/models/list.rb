class List < ApplicationRecord 
    validates :name, presence: true
    # validates :items, :length => { :minimum => 1, :message => "must be present in recipe."}
    # won't work because purchase items cannot be created without a list and vice versa

    has_many :list_recipes
    has_many :recipes, through: :list_recipes
    has_many :recipe_items, through: :recipes

    has_many :additional_items

    has_many :purchase_items
    has_many :items, through: :purchase_items

    belongs_to :user

    accepts_nested_attributes_for :recipes
    accepts_nested_attributes_for :additional_items
    accepts_nested_attributes_for :purchase_items

    def set_name_and_user(current_user,list_params)
        list_name = list_params[:name]
        if list_name == ""
            list_name = Time.now.strftime("List created %m/%d/%Y at %I:%M%p")
        end
        self.update(
            name: list_name,
            user_id: current_user.id
            )
    end

    def add_recipes(list_params)
        list_params[:recipes_attributes].each do |recipe_attributes_array|
            recipe_attributes = recipe_attributes_array.last
            if recipe_attributes[:included] == "1"
                list_recipe = self.list_recipes.build(recipe_id: recipe_attributes[:id].to_i)
                list_recipe.save
                list_recipe.recipe.recipe_items.each do |recipe_item|
                    purchase_item = PurchaseItem.find_or_create_by(item_id: recipe_item.item.id, list_id: self.id)
                    purchase_item.update(name: purchase_item.item.name)
                    if purchase_item.quantity == ""
                        purchase_item.quantity += recipe_item.quantity
                    else
                        purchase_item.quantity += (", " + recipe_item.quantity)
                    end
                    purchase_item.save
                end
            end
        end
    end

    def add_additional_items(list_params)
        list_params[:additional_items_attributes].each do |additional_items_array|
            additional_item_attributes = additional_items_array.last
            name = additional_item_attributes[:name]
            if name != ""
                additional_item = self.additional_items.build(
                    item_id: Item.find_or_create_by(name: name).id,
                    quantity: additional_item_attributes[:quantity]
                    )
                additional_item.save
                purchase_item = PurchaseItem.find_or_create_by(item_id: additional_item.item.id, list_id: self.id)
                purchase_item.update(name: purchase_item.item.name)
                if purchase_item.quantity == ""
                    purchase_item.quantity += additional_item.quantity
                else
                    purchase_item.quantity += (", " + additional_item.quantity)
                end
                purchase_item.save
                # raise self.inspect
            end
        end
    end

    def update_details(list_params)
        list_params[:purchase_items_attributes].each do |purchase_items_attribute_array|
            purchase_items_attributes = purchase_items_attribute_array.last
            purchase_item = PurchaseItem.find(purchase_items_attributes[:id].to_i)
            if purchase_items_attributes[:included] == "0"
                purchase_item.destroy
            else
                item = purchase_item.item
                purchase_item.quantity = purchase_items_attributes[:quantity]
                purchase_item.save
                grocery_category = GroceryCategory.find(purchase_items_attribute_array.last[:grocery_category_id].to_i)
                item.grocery_category = grocery_category
                item.save
            end 
        end
    end

    def clear_items_from_list
        self.purchase_items.destroy_all
        self.list_recipes.destroy_all
        self.additional_items.destroy_all
    end

end

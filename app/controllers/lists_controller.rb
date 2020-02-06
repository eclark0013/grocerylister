class ListsController < ApplicationController
    before_action :require_login

    def index
        if current_user
            @your_lists = List.where(user_id: current_user.id)
            @public_lists = List.where.not(user_id: current_user.id)
            @user = current_user
        else
            redirect_to "/login"
        end
    end
    
    def show
        @list = List.find(params[:id])
        @user = current_user
        @purchase_items = @list.purchase_items.order(:name)
    end

    def new
        if params[:user_id].to_i != current_user.id 
            redirect_to root
        else
            @user = current_user
            @list = List.new
        end
        # set up to add a recipe but with option to unselect items as desired
        # maybe like a "do you want all of this?" page where you can unselect
        # items before it is made into a real list
    end

    def create
        @list = List.new
        @list.set_name_and_user(current_user, list_params)
        @list.purchase_items.destroy_all
        # add_recipes_to_list and find or create purchase items
        list_params[:recipes_attributes].each do |recipe_attributes_array|
            recipe_attributes = recipe_attributes_array.last
            if recipe_attributes[:included] == "1"
                list_recipe = @list.list_recipes.build(recipe_id: recipe_attributes[:id].to_i)
                list_recipe.save
                list_recipe.recipe.recipe_items.each do |recipe_item|
                    purchase_item = PurchaseItem.find_or_create_by(item_id: recipe_item.item.id, list_id: @list.id)
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
        # add_additional_items_to_list
        list_params[:additional_items_attributes].each do |additional_items_array|
            additional_item_attributes = additional_items_array.last
            name = additional_item_attributes[:name]
            if name != ""
                additional_item = @list.additional_items.build(
                    item_id: Item.find_or_create_by(name: name).id,
                    quantity: additional_item_attributes[:quantity]
                    )
                additional_item.save
                purchase_item = PurchaseItem.find_or_create_by(item_id: additional_item.item.id, list_id: @list.id)
                purchase_item.update(name: purchase_item.item.name)
                if purchase_item.quantity == ""
                    purchase_item.quantity += additional_item.quantity
                else
                    purchase_item.quantity += (", " + additional_item.quantity)
                end
                purchase_item.save
            end
        end
        redirect_to user_list_path(current_user, @list)
    end

    def edit
        @list = List.find(params[:id])
        @user = current_user 
    end

    def update
        @list = List.find(params[:id])
        @list.set_name_and_user(current_user, list_params)
        @list.purchase_items.destroy_all
        ListRecipe.all.where(list_id: @list.id).destroy_all # clear out recipes to prepare for restocking
        # add_recipes_to_list
        list_params[:recipes_attributes].each do |recipe_attributes_array|
            recipe_attributes = recipe_attributes_array.last
            if recipe_attributes[:included] == "1"
                list_recipe = @list.list_recipes.build(recipe_id: recipe_attributes[:id].to_i)
                list_recipe.save
                list_recipe.recipe.recipe_items.each do |recipe_item|
                    purchase_item = PurchaseItem.find_or_create_by(item_id: recipe_item.item.id, list_id: @list.id)
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
        AdditionalItem.all.where(list_id: @list.id).destroy_all # clear out additional items to prepare for restocking
        # add_additional_items_to_list
        list_params[:additional_items_attributes].each do |additional_items_array|
            additional_item_attributes = additional_items_array.last
            name = additional_item_attributes[:name]
            if name != ""
                @list.additional_items.build(
                    item_id: Item.find_or_create_by(name: name).id,
                    quantity: additional_item_attributes[:quantity]
                    ).save
            end
        end
        redirect_to user_list_path(current_user, @list)
    end

    def edit_details #allow user to edit category, quantity, and remove items from list based on kitchen inventory
        @list = List.find(params[:id])
        @user = current_user
        @purchase_items = @list.purchase_items.order(:name)
    end

    def update_details
        @list = List.find(params[:id])
        @user = current_user
        @purchase_items = @list.purchase_items.order(:name)
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
        redirect_to user_list_path(@user, @list)
    end

    def destroy 
        List.find(params[:id]).destroy
        redirect_to user_lists_path(current_user)
    end

    private
    def list_params
        params.require(:list).permit(:name, recipes_ids:[], recipes_attributes: [:included, :id], additional_items_attributes: [:name, :quantity], purchase_items_ids:[], purchase_items_attributes: [:grocery_category_id, :id, :included, :quantity]).to_h
    end 

end

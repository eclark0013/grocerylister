class ListsController < ApplicationController
    
    def show
        @list = List.find(params[:id])
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
        list_name = list_params[:name]
        if list_name == ""
            list_name = Time.now.strftime("List created %m/%d/%Y at %I:%M%p")
        end
        list = List.create(
            name: list_name,
            user_id: current_user.id
            )
        # add_recipes_to_list
        list_params[:recipes_attributes].each do |recipe_attributes_array|
            recipe_attributes = recipe_attributes_array.last
            if recipe_attributes[:included] == "1"
                list.list_recipes.build(recipe_id: recipe_attributes[:id].to_i).save
            end
        end
        # add_additional_items_to_list
        list_params[:additional_items_attributes].each do |additional_items_array|
            additional_item_attributes = additional_items_array.last
            name = additional_item_attributes[:name]
            if name != ""
                list.additional_items.build(
                    item_id: Item.find_or_create_by(name: name).id,
                    quantity: additional_item_attributes[:quantity]
                    ).save
            end
        end
        redirect_to user_list_path(current_user, list)
    end

    def edit
    end

    def update
    end

    private
    def list_params
        params.require(:list).permit(:name, recipes_ids:[], recipes_attributes: [:included, :id], additional_items_attributes: [:name, :quantity]).to_h
    end 

end

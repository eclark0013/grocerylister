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
        list = List.create(name: list_params[:name], user_id: current_user.id)
        list_params[:recipes_attributes].each do |recipe_attributes_array|
            recipe_attributes = recipe_attributes_array.last
            if recipe_attributes[:included] == "1"
                list.list_recipes.build(recipe_id: recipe_attributes[:id].to_i).save
            end
        end
        raise list.inspect
    end

    private
    def list_params
        params.require(:list).permit(:name, recipes_ids:[], recipes_attributes: [:included, :id]).to_h
    end 

end

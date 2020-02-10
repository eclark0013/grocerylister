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
    end

    def create
        @list = List.new
        @list.set_name_and_user(current_user, list_params)
        @list.add_recipes(list_params)
        @list.add_additional_items(list_params)
        redirect_to user_list_path(current_user, @list) 
    end

    def edit
        @list = List.find(params[:id])
        @user = current_user 
    end

    def update
        @list = List.find(params[:id])
        @list.set_name_and_user(current_user, list_params)
        @list.clear_items_from_list
        @list.add_recipes(list_params)
        @list.add_additional_items(list_params)
        @list.save
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
        @list.update_details(list_params)
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

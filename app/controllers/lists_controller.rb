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
        raise params.inspect
    end

end

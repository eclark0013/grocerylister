class ListsController < ApplicationController
    
    def show
        @list = List.find(params[:id])
    end

    def new
        # set up to add a recipe but with option to unselect items as desired
        # maybe like a "do you want all of this?" page where you can unselect
        # items before it is made into a real list
    end

end

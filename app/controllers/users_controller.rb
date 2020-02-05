class UsersController < ApplicationController
    def show
        if params[:id]
            @user = User.find(params[:id])
        else
            @user = current_user
        end
    end

    def new
        @user = User.new
    end

    def create
        @user = User.create(user_params)
        session[:name] = @user.name
        redirect_to user_path(@user)
    end

    private

    def user_params
        params.require(:user).permit(:name, :password)
    end
end

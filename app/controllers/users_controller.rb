class UsersController < ApplicationController
    def show
        require_login
        @user = User.find_by(id: params[:id])
        if @user == nil
            redirect_to root_path
        end
    end

    def home #root path
        require_login
        @user = current_user
        render "show"
    end

    def new #sign up page
        @user = User.new
    end

    def create #make a new user
        @user = User.create(user_params)
        session[:name] = @user.name
        redirect_to user_path(@user)
    end

    private

    def user_params
        params.require(:user).permit(:name, :password)
    end
end

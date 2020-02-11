class UsersController < ApplicationController
    def show
        require_login
        @user = User.find_by(id: params[:id])
        if @user == nil
            redirect_to root_path
        end
    end

    def home #root path
        if require_login
        else
            @user = current_user
            render "show"
        end
    end

    def new #sign up page
        @user = User.new
    end

    def create #make a new user
        @user = User.create(user_params)
        session[:user_id] = @user.id
        redirect_to user_path(@user)
    end

    private

    def user_params
        params.require(:user).permit(:name, :password)
    end
end

class UsersController < ApplicationController
    before_action :require_login, only: [:show, :home]

    def index
        @users = User.all
    end

    def show
        flash[:error_messages] = nil
        @user = User.find_by(id: params[:id])
        if @user == nil
            redirect_to root_path
        end
    end

    def home #root path
        flash[:error_messages] = nil
        redirect_to user_path(current_user)
    end

    def new #sign up page
        @user = User.new
    end

    def create #make a new user
        @user = User.create(user_params)
        if @user.valid?
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            flash[:error_messages] = @user.errors.full_messages
            render "new"
        end
    end

    private
    def user_params
        params.require(:user).permit(:name, :password)
    end
end

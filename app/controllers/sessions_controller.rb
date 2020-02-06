class SessionsController < ApplicationController
    
    def new #login page
        if session[:name]
            redirect_to user_path(User.find_by(name: session[:name]))
        end
    end

    def create #login a user
        @user = User.find_by(name: user_params[:name])
        if @user && @user.authenticate(user_params[:password])
           session[:name] = @user.name
           redirect_to user_path(@user)
        else 
            render "new"
        end
    end

    def destroy
        session.delete :name
        redirect_to action: "new"
    end

    private
    def user_params
        params.require(:user).permit(:name, :password)
    end
end

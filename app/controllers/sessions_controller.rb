class SessionsController < ApplicationController
    def new   
        if session[:name]
            redirect_to "/"
        end
    end

    def create
        @user = User.find_by(name: params[:user][:name])
        if @user && @user.authenticate(params[:user][:password])
           session[:name] = @user.name
           redirect_to "/" 
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

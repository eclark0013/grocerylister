class SessionsController < ApplicationController
    
    def new #login page
        if session[:user_id]
            redirect_to user_path(User.find(session[:user_id]))
        end
        @user = User.new
    end

    def create #login a user
        if @user = User.find_by(name: user_params[:name])
            if @user.authenticate(user_params[:password])
                session[:user_id] = @user.id
                redirect_to user_path(@user)
            else 
                flash[:error_messages] = ["Incorrect password."]
                render "new"
            end
        else
            @user = User.new(name: user_params[:name])
            flash.now[:error_messages] = ["No existing user by that name. Try again or sign up as new user."]
            render "new"
        end
    end

    def omniauth_create #login a user with facebook using omniauth gem 
        @user = User.find_or_create_by(id: auth['uid']) do |u|
            u.name = auth['info']['name']
            # u.email = auth['info']['email']
        end
        @user.password = "facebook user"
        @user.save
        session[:user_id] = @user.id
        redirect_to user_path(@user)
    end

    def destroy
        session.delete :user_id
        redirect_to action: "new"
    end

    private
    def user_params
        params.require(:user).permit(:name, :password)
    end
 
    def auth
        request.env['omniauth.auth']
    end
end

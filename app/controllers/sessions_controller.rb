class SessionsController < ApplicationController
    def new   
        @user = User.new
    end

    def create
        if named_session?
            @user = User.find(name: params[:name])
            if @user.authenticate(params[:password])
                session[:name] = @user.name
                raise @user.inspect
                redirect_to "/"
            end
        else
            redirect_to action: "new" 
        end 
    end

    def destroy
        session.delete :name
        redirect_to action: "new"
    end
end

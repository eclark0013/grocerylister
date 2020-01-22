class SessionsController < ApplicationController
    def new   
    end

    def create
        if named_session?
            session[:name] = params[:name]
            redirect_to "/"
        else
            redirect_to action: "new" 
        end 
    end

    def destroy
        session.delete :name
        redirect_to action: "new"
    end
end

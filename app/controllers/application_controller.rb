class ApplicationController < ActionController::Base
    def current_user
        if session[:user_id]
            User.find(session[:user_id])
        else
            nil
        end
    end

    def require_login
        redirect_to "/login" if !session[:user_id]
    end

end

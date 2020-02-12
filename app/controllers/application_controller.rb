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

    def redirect_hacker(object, redirect_path)
        if object.user != current_user
            redirect_to redirect_path
        end
    end

end

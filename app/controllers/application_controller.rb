class ApplicationController < ActionController::Base
    def current_user
        if session[:name]
            User.find_by(name: session[:name])
        else
            nil
        end
    end

    def require_login
        if !session[:name]
            redirect_to "/login"
        end
    end
end

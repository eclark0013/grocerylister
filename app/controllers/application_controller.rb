class ApplicationController < ActionController::Base
    def current_user
        User.find_by(id: session[:user_id])
    end

    def require_login
        redirect_to "/login" if !session[:user_id]
    end

end

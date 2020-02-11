class ApplicationController < ActionController::Base
    def current_user
        if session[:user_id]
            User.find(session[:user_id])
        else
            nil
        end
    end

    def require_login
        if !session[:user_id]
            redirect_to "/login"
        end
    end

    def set_to_current_time(list_name)
        if list_name == ""
            list_name = Time.now.strftime("List created %m/%d/%Y at %I:%M%p")
        end
    end

end

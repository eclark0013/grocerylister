module SessionsHelper
    def current_user
        if session[:name]
            User.find_by(name: session[:name])
        else
            nil
        end
    end
end

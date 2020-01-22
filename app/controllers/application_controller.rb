class ApplicationController < ActionController::Base
    def named_session?
        !(params[:name].nil? || params[:name]=="")
    end
end

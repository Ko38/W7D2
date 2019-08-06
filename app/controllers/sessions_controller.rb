class SessionsController < ApplicationController
    def new
        render :new
    end

    def create
        user = User.find_by_credentials(user_params[:email], user_params[:password])
        if user.nil?
            render :new
            return
        end
        log_in_user!(user)
        render :new
    end

    def destroy
        log_out_user!
        render :new
    end

    def user_params
        params.permit(:email, :password)
    end
end

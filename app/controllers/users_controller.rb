class UsersController < ApplicationController

    def new
        render :new
    end

    def create
        user = User.new(user_params)
        if user.save    
            log_in_user!(user)        
        end
        render :new
    end

    def show
        @user = User.find(params[:id])
        render :show
    end

    private

  def user_params
    params.permit(:email, :password)
  end
end

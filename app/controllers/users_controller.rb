class UsersController < ApplicationController
    def index
        @users = User.all
        render json: @users, status: :ok
    end

    def show
        @user = User.find(params[:id])
        render json: @user, status: :ok
    end

    def update
        render json: {'msg': "Updated the details in user #{params[:id]}"}, status: :ok
    end

    def create
        @user = User.new(user_params)
        if @user.save
          render json: {'msg': 'User created successfully'}, status: :created
        else
          render json: @user.errors.full_messages, status: :unprocessable_entity
        end      
    end

    private
    def user_params
      params.require(:user).permit(:username)
    end    
end
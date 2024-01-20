class UsersController < ApplicationController

    # POST /users
    def create
      @user = User.new(user_params)
      if @user.save
        render json: @user, status: :created, location: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  
    # GET /users/:id
    def show
      # @user = User.find(params[:id])
      # render json: @user
      begin
        @user = User.find(params[:id])
        render json: @user
      rescue ActiveRecord::RecordNotFound => e
        render json: { error: e.class.to_s, message: e.message }, status: :not_found
      end
    end
  
    private
    def user_params
      params.require(:user).permit(:name)
    end
  end
  
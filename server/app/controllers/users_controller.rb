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
      begin
        @user = User.find(params[:id])
        render json: @user
      rescue ActiveRecord::RecordNotFound => e
        render json: { error: e.class.to_s, message: e.message }, status: :not_found
      rescue => e
        # 予期しないエラーの場合の処理
        logger.error "Internal Server Error: #{e.class} - #{e.message}"
        e.backtrace.each { |line| logger.error line }
        render json: { error: 'Internal Server Error', message: 'An unexpected error has occurred.' }, status: :internal_server_error
      end
    end
  
    private
    def user_params
      params.require(:user).permit(:name)
    end
  end
  
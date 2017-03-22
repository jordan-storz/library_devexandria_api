class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    if params[:username] then
      @user = User.find_or_create_by({username: params[:username]})
      if @user.library == nil then
        @user.library = Library.create(user: @user)
      end
      render json: @user, include: ['library', 'followees', 'followers']
    else
      @users = User.all
      render json: @users
    end

  end

  # GET /users/1
  def show
    render json: @user, include: ['library', 'followees', 'followers']
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
      # @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      # params.require(:user).permit(:username, :library_id)
      res = ActiveModelSerializers::Deserialization.jsonapi_parse(params)
      res
    end
end

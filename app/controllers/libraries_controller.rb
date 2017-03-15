class LibrariesController < ApplicationController
  before_action :set_library, only: [:show, :update, :destroy]

  # GET /libraries
  def index
    if params[:user_id] then
      puts "looking for library"
      @user = User.find(params[:user_id])
      @library = @user.library

      render json: @library
    else
      @libraries = Library.all

      render json: @libraries
    end
  end

  # GET /libraries/1
  def show
    render json: @library, include: ['books', 'user', 'tags']
  end

  # POST /libraries
  def create
    @library = Library.new(library_params)

    if @library.save
      render json: @library, status: :created, location: @library
    else
      render json: @library.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /libraries/1
  def update
    if @library.update(library_params)
      render json: @library
    else
      render json: @library.errors, status: :unprocessable_entity
    end
  end

  # DELETE /libraries/1
  def destroy
    @library.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_library
      @library = Library.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def library_params
      # params.require(:library).permit(:user_id, :book_id)
      res = ActiveModelSerializers::Deserialization.jsonapi_parse(params)
      res
    end
end

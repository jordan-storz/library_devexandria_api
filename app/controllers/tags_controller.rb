class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :update, :destroy]

  # GET /tags
  def index
    if params[:name] then
      @tag = Tag.find_or_create_by({name: params[:name]})
      puts "FINDING TAG"
      puts @tag
      render json: @tag, include: ['libraries', 'books']
    else
      @tags = Tag.all
      render json: @tags
    end
  end

  # GET /tags/1
  def show
    render json: @tag, include: ['books']
  end

  # POST /tags
  def create
    @tag = Tag.new(tag_params)
    puts "SAVING TAG< BUT FIRST..."
    puts tag_params
    # if @tag.save
    #   render json: @tag, status: :created, location: @tag
    # else
    #   render json: @tag.errors, status: :unprocessable_entity
    # end
  end

  # PATCH/PUT /tags/1
  def update
    if @tag.update(tag_params)
      render json: @tag
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tags/1
  def destroy
    @tag.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tag_params
      res = ActiveModelSerializers::Deserialization.jsonapi_parse(params)
      res
    end
end

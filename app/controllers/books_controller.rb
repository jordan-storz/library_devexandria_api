class BooksController < ApplicationController
  before_action :set_book, only: [:show, :update, :destroy]

  # GET /books
  def index
    if params[:source_url] then
      puts "looking for book"
      @book = Book.find_or_create_by(source_url: params[:source_url])

      render json: @book, include: ['tags', 'libraries']
    else
      @books = Book.all

      render json: @books
    end
  end

  # GET /books/1
  def show
    render json: @book, include: ['tags']
  end

  # POST /books
  def create
    @book = Book.find_or_create_by(source_url: book_params[:source_url])
    puts "PARAMS"
    puts book_params

    if @book.title then
      if @book.update(book_params)
        render json: @book
      else
        render json: @book.errors, status: :unprocessable_entity
      end
    else
      @book_details = HTTParty.post(
        'http://localhost:5200/populate',
        body: {
          url: book_params[:source_url]
        }.to_json,
        headers: {
          'Content-Type' => 'application/json'
        }
      )
      @params = book_params.merge @book_details.symbolize_keys
      if @book_details["tags"] then
        @tag_ids = []
        puts "THERE ARE TAGS FOR SURE"
        @book_details["tags"].each do |tagname|
          tag = Tag.find_or_create_by(name: tagname)
          puts tag
          @params[:tag_ids].push tag.id
        end
      end

      @params.delete :tags
      puts "symbol hash"
      puts @params
      if @book.update(@params)
        render json: @book
      else
        render json: @book.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /books/1
  def update
    if @book.title then
      puts "doing a regular old update"
      if @book.update(book_params)
        render json: @book
      else
        render json: @book.errors, status: :unprocessable_entity
      end
    else
      puts "book needs scraping"
      puts @book.title
      @book_details = HTTParty.post(
        'http://localhost:5200/populate',
        body: {
          url: book_params[:source_url]
        }.to_json,
        headers: {
          'Content-Type' => 'application/json'
        }
      )
      @params = book_params.merge @book_details.symbolize_keys
      if @book_details["tags"] then
        @tag_ids = []
        puts "THERE ARE TAGS FOR SURE"
        @book_details["tags"].each do |tagname|
          tag = Tag.find_or_create_by(name: tagname)
          puts tag
          @params[:tag_ids].push tag.id
        end
      end

      @params.delete :tags
      puts "symbol hash"
      puts @params
      if @book.update(@params)
        render json: @book
      else
        render json: @book.errors, status: :unprocessable_entity
      end
    end
    # if @book.update(book_params)
    #   render json: @book
    # else
    #   render json: @book.errors, status: :unprocessable_entity
    # end
  end

  # DELETE /books/1
  def destroy
    @book.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def book_params
      # params.require(:book).permit(:title, :content, :source_url, :library_id, :tag_id)
      res = ActiveModelSerializers::Deserialization.jsonapi_parse(params)
      res
    end
end

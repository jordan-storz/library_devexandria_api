class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]

  def index
    if params[:book_id] then
      puts "Searching for event based on book."
      puts "params:"
      puts params[:user_id]
      @event = Event.where({
        book_id: params[:book_id],
        user_id: params[:user_id],
        library_id: params[:library_id],
        event_type: params[:event_type]
      }).first
      puts "found an event..."
      puts @event
      render json: @event
    elsif params[:user_ids] then
      @events = Event.where(user: params[:user_ids]).order('updated_at desc')
      render json: @events, include: ['user', 'book']
    else
      @events = Event.all
      render json: @events
    end
  end

  def show
    render json: @event
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      render json: @event, status: :created, location: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  def update
    if @event.update(event_params)
      @event.touch
      render json: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  private

    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def event_params
      res = ActiveModelSerializers::Deserialization.jsonapi_parse(params)
      res
    end


end

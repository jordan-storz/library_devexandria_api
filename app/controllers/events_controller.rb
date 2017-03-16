class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]

  def index
    if params[:user_ids] then
      @events = Event.where(user: params[:user_ids])
      render json: @events, include: ['user', 'book']
    else
      @events = Event.all
      render json: @events
    end
  end

  def show
    render json: @event, include: ['user', 'book']
  end

  private

    def set_event
      @tag = Event.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def event_params
      res = ActiveModelSerializers::Deserialization.jsonapi_parse(params)
      res
    end


end

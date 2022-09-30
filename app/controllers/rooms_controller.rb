class RoomsController < ApplicationController
  before_action :set_room, only: %i[ show ]

  # GET /rooms
  def index
    @rooms = Room.all.order(created_at: :desc)
  end

  # GET /rooms/1
  def show
    @room = Room.find(params[:id])
    @room_photos = @room.room_photos.all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end
end

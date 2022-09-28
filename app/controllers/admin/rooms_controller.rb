class Admin::RoomsController < ApplicationController
  before_action :set_admin_room, only: %i[ show edit update destroy ]

  # GET /admin/rooms
  def index
    @admin_rooms = Admin::Room.all
  end

  # GET /admin/rooms/1
  def show
  end

  # GET /admin/rooms/new
  def new
    @admin_room = Admin::Room.new
  end

  # GET /admin/rooms/1/edit
  def edit
  end

  # POST /admin/rooms
  def create
    @admin_room = Admin::Room.new(admin_room_params)
    p admin_room_params
    # p params.require(:room).permit(:room_name, :short_description, :long_description, :price)
    if @admin_room.save
      flash[:success] = "Room was successfully created."
      redirect_to admin_room_url(@admin_room)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/rooms/1
  def update
    if @admin_room.update(admin_room_params)
      flash[:success] = "Room was successfully updated."
      redirect_to admin_room_url(@admin_room)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/rooms/1
  def destroy
    @admin_room.destroy

    flash[:success] = "Room was successfully destroyed."
    redirect_to admin_rooms_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_room
    @admin_room = Admin::Room.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def admin_room_params
    params.require(:admin_room).permit(:room_name, :short_description, :long_description, :price)
  end
end

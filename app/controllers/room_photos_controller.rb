class RoomPhotosController < ApplicationController
  before_action :set_room_photo, only: %i[ show edit update destroy ]

  # GET /room_photos
  def index
    @room_photos = RoomPhoto.all.order(created_at: :desc)
  end

  # GET /room_photos/1
  def show
    p @room_photo.room
  end

  # GET /room_photos/new
  def new
    @room_photo = RoomPhoto.new
  end

  # GET /room_photos/1/edit
  def edit
    @room = @room_photo.room
  end

  # POST /room_photos
  def create
    @room_photo = RoomPhoto.new(room_photo_params)
    if @room_photo.save
      flash[:success] = "Room photo was successfully created."
      redirect_to room_photo_url(@room_photo)
    else
      flash[:danger] = "Can't create photo"
      render 'admin/rooms/new', status: :unprocessable_entity
    end
  end

  # PATCH/PUT /room_photos/1
  def update
    if @room_photo.update(room_photo_params)
      flash[:success] = "Room photo was successfully updated."
      redirect_to room_photo_url(@room_photo)
    else
      flash[:danger] = "Can't update photo"
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /room_photos/1
  def destroy
    @room_photo.destroy

    flash[:success] = "Room photo was successfully destroyed."
    redirect_to @room_photo.room
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_room_photo
    @room_photo = RoomPhoto.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def room_photo_params
    params.require(:room_photo).permit(:room_id, :photo)
  end
end

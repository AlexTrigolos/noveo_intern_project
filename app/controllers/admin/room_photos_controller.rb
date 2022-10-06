class Admin::RoomPhotosController < ApplicationController
  before_action :set_room_photo, only: %i[ show edit update destroy ]

  # GET /room_photos
  def index
    @admin_room_photos = Admin::RoomPhoto.all.order(created_at: :desc)
    authorize @admin_room_photos
  end

  # GET /room_photos/1
  def show
  end

  # GET /room_photos/1/edit
  def edit
    @room = @admin_room_photo.room
  end

  # POST /room_photos
  def create
    @admin_room_photo = Admin::RoomPhoto.new(room_photo_params)
    authorize @admin_room_photo
    if @admin_room_photo.save
      flash[:success] = "Room photo was successfully created."
      redirect_to admin_room_photo_url(@admin_room_photo)
    else
      flash[:danger] = "Can't create photo"
      render 'admin/rooms/new', status: :unprocessable_entity
    end
  end

  # PATCH/PUT /room_photos/1
  def update
    if @admin_room_photo.update(room_photo_params)
      flash[:success] = "Room photo was successfully updated."
      redirect_to admin_room_photo_url(@admin_room_photo)
    else
      flash[:danger] = "Can't update photo"
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /room_photos/1
  def destroy
    @admin_room_photo.destroy

    flash[:success] = "Room photo was successfully destroyed."
    redirect_to @admin_room_photo.room
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_room_photo
    @admin_room_photo = Admin::RoomPhoto.find(params[:id])
    authorize @admin_room_photo
  end

  # Only allow a list of trusted parameters through.
  def room_photo_params
    params.require(:admin_room_photo).permit(:room_id, :photo)
  end
end

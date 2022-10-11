# frozen_string_literal: true

module Admin
  class RoomsController < ApplicationController
    before_action :set_admin_room, only: %i[show edit update destroy]

    # GET /admin/rooms
    def index
      @admin_rooms = Admin::Room.all.order(created_at: :desc)
      authorize @admin_rooms
    end

    # GET /admin/rooms/1
    def show
      @room_photos = @admin_room.room_photos.all.order(created_at: :asc)
    end

    # GET /admin/rooms/new
    def new
      @admin_room = Admin::Room.new
      authorize @admin_room
    end

    # GET /admin/rooms/1/edit
    def edit; end

    # POST /admin/rooms
    def create
      @admin_room = Admin::Room.new(admin_room_params)
      authorize @admin_room
      if @admin_room.save
        create_room_photos
        flash[:success] = t('.success')
        redirect_to admin_room_url(@admin_room)
      else
        render :new, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /admin/rooms/1
    def update
      if @admin_room.update(admin_room_params)
        create_room_photos
        flash[:success] = t('.success')
        redirect_to admin_room_url(@admin_room)
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /admin/rooms/1
    def destroy
      @admin_room.destroy

      flash[:success] = t('.success')
      redirect_to admin_rooms_url
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_admin_room
      @admin_room = Admin::Room.find(params[:id])
      authorize @admin_room
    end

    def create_room_photos
      params[:room_photos]['photo'].each do |a|
        @room_photo = @admin_room.room_photos.create!(photo: a, room_id: @admin_room.id) if a != ''
      end
    end

    # Only allow a list of trusted parameters through.
    def admin_room_params
      params.require(:admin_room).permit(:room_name, :short_description, :long_description, :price)
    end
  end
end

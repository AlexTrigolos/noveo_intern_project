class PagesController < ApplicationController
  def index
    @photos_ids = []
    Room.includes(:room_photos).find_each do |room|
      room.room_photos.order(created_at: :desc).limit(2).each { |el| @photos_ids.push(el.id) }
    end
    @hotel_photos = RoomPhoto.where(id: @photos_ids).limit(10)
  end
end

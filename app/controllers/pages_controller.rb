class PagesController < ApplicationController
  def index
    @hotel_photos = RoomPhoto.all.order(created_at: :desc).limit(10)
  end
end

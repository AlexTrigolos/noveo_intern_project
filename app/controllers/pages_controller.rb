# frozen_string_literal: true

class PagesController < ApplicationController
  def index
    @hotel_photos = hotel_photos
    @kelvin = 273.15
    @lat = params[:lat] || 59.9386
    @lon = params[:lon] || 30.3141
    api = ENV.fetch('API_OPEN_WEATHER', nil)
    response = HTTParty.get("https://api.openweathermap.org/data/2.5/weather?lat=#{@lat}&lon=#{@lon}&appid=#{api}")
    @response_body_json = ActiveSupport::JSON.decode(response.body)
  end

  private

  def hotel_photos
    photos_ids = []
    Room.find_each do |room|
      room.room_photos.order(created_at: :desc).limit(2).each { |el| photos_ids.push(el.id) }
    end
    Admin::RoomPhoto.where(id: photos_ids).limit(10)
  end
end

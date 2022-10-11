# frozen_string_literal: true

class Room < ApplicationRecord
  has_many :rooms_bookings, dependent: :destroy
  has_many :room_photos, class_name: 'Admin::RoomPhoto', dependent: :destroy
  accepts_nested_attributes_for :room_photos
end

class Room < ApplicationRecord
  has_many :rooms_bookings, dependent: :destroy
  has_many :room_photos
  accepts_nested_attributes_for :room_photos
end

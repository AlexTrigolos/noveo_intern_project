class Room < ApplicationRecord
  has_many :room_photos
  accepts_nested_attributes_for :room_photos
end
